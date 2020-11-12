//backpack item
#define HALFWAYCRITDEATH ((HEALTH_THRESHOLD_CRIT + HEALTH_THRESHOLD_DEAD) * 0.5)

/obj/item/defibrillator
	name = "defibrillator"
	desc = "A device that delivers powerful shocks to detachable paddles that resuscitate incapacitated patients."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "defibunit"
	item_state = "defibunit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	slot_flags = ITEM_SLOT_BACK
	force = 5
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY
	actions_types = list(/datum/action/item_action/toggle_paddles)
	armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "rad" = 0, "fire" = 50, "acid" = 50)

	var/on = FALSE //if the paddles are equipped (1) or on the defib (0)
	var/safety = TRUE //if you can zap people with the defibs on harm mode
	var/powered = FALSE //if there's a cell in the defib with enough power for a revive, blocks paddles from reviving otherwise
	var/obj/item/twohanded/shockpaddles/paddles
	var/obj/item/stock_parts/cell/high/cell
	var/combat = FALSE //can we revive through space suits?
	var/grab_ghost = FALSE // Do we pull the ghost back into their body?
	var/healdisk = FALSE // Will we shock people dragging the body?
	var/pullshocksafely = FALSE //Dose the unit have the healdisk upgrade?
	var/primetime = 10 // is the defib faster
	var/timedeath = 10

/obj/item/defibrillator/get_cell()
	return cell

/obj/item/defibrillator/Initialize() //starts without a cell for rnd
	. = ..()
	paddles = make_paddles()
	update_icon()
	return

/obj/item/defibrillator/loaded/Initialize() //starts with hicap
	. = ..()
	paddles = make_paddles()
	cell = new(src)
	update_icon()
	return

/obj/item/defibrillator/update_icon()
	update_power()
	update_overlays()
	update_charge()

/obj/item/defibrillator/proc/update_power()
	if(!QDELETED(cell))
		if(QDELETED(paddles) || cell.charge < paddles.revivecost)
			powered = FALSE
		else
			powered = TRUE
	else
		powered = FALSE

/obj/item/defibrillator/proc/update_overlays()
	cut_overlays()
	if(!on)
		add_overlay("[initial(icon_state)]-paddles")
	if(powered)
		add_overlay("[initial(icon_state)]-powered")
	if(!cell)
		add_overlay("[initial(icon_state)]-nocell")
	if(!safety)
		add_overlay("[initial(icon_state)]-emagged")

/obj/item/defibrillator/proc/update_charge()
	if(powered) //so it doesn't show charge if it's unpowered
		if(!QDELETED(cell))
			var/ratio = cell.charge / cell.maxcharge
			ratio = CEILING(ratio*4, 1) * 25
			add_overlay("[initial(icon_state)]-charge[ratio]")

/obj/item/defibrillator/CheckParts(list/parts_list)
	..()
	cell = locate(/obj/item/stock_parts/cell) in contents
	update_icon()

/obj/item/defibrillator/ui_action_click()
	toggle_paddles()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/item/defibrillator/attack_hand(mob/user)
	if(loc == user)
		if(slot_flags == ITEM_SLOT_BACK)
			if(user.get_item_by_slot(SLOT_BACK) == src)
				ui_action_click()
			else
				to_chat(user, "<span class='warning'>Put the defibrillator on your back first!</span>")

		else if(slot_flags == ITEM_SLOT_BELT)
			if(user.get_item_by_slot(SLOT_BELT) == src)
				ui_action_click()
			else
				to_chat(user, "<span class='warning'>Strap the defibrillator's belt on first!</span>")
		return
	else if(istype(loc, /obj/machinery/defibrillator_mount))
		ui_action_click() //checks for this are handled in defibrillator.mount.dm
	return ..()

/obj/item/defibrillator/MouseDrop(obj/over_object)
	. = ..()
	if(ismob(loc))
		var/mob/M = loc
		if(!M.incapacitated() && istype(over_object, /obj/screen/inventory/hand))
			var/obj/screen/inventory/hand/H = over_object
			M.putItemFromInventoryInHandIfPossible(src, H.held_index)

/obj/item/defibrillator/attackby(obj/item/W, mob/user, params)
	if(W == paddles)
		paddles.unwield()
		toggle_paddles()
	else if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, "<span class='notice'>[src] already has a cell.</span>")
		else
			if(C.maxcharge < paddles.revivecost)
				to_chat(user, "<span class='notice'>[src] requires a higher capacity cell.</span>")
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, "<span class='notice'>You install a cell in [src].</span>")
			update_icon()

	else if(istype(W, /obj/item/screwdriver))
		if(cell)
			cell.update_icon()
			cell.forceMove(get_turf(src))
			cell = null
			to_chat(user, "<span class='notice'>You remove the cell from [src].</span>")
			update_icon()
	else
		return ..()

/obj/item/defibrillator/emag_act(mob/user)
	. = ..()
	safety = !safety
	to_chat(user, "<span class='warning'>You silently [safety ? "enable" : "disable"] [src]'s safety protocols with the cryptographic sequencer.</span>")
	return TRUE

/obj/item/defibrillator/emp_act(severity)
	. = ..()
	if(cell && !(. & EMP_PROTECT_CONTENTS))
		deductcharge(1000 / severity)
	if (. & EMP_PROTECT_SELF)
		return
	if(safety)
		safety = FALSE
		visible_message("<span class='notice'>[src] beeps: Safety protocols disabled!</span>")
		playsound(src, 'sound/machines/defib_saftyOff.ogg', 50, 0)
	else
		safety = TRUE
		visible_message("<span class='notice'>[src] beeps: Safety protocols enabled!</span>")
		playsound(src, 'sound/machines/defib_saftyOn.ogg', 50, 0)
	update_icon()

/obj/item/defibrillator/proc/toggle_paddles()
	set name = "Toggle Paddles"
	set category = "Object"
	on = !on

	var/mob/living/carbon/user = usr
	if(on)
		//Detach the paddles into the user's hands
		if(!usr.put_in_hands(paddles))
			on = FALSE
			to_chat(user, "<span class='warning'>You need a free hand to hold the paddles!</span>")
			update_icon()
			return
	else
		//Remove from their hands and back onto the defib unit
		paddles.unwield()
		remove_paddles(user)

	update_icon()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/defibrillator/proc/make_paddles()
	return new /obj/item/twohanded/shockpaddles(src)

/obj/item/defibrillator/equipped(mob/user, slot)
	..()
	if((slot_flags == ITEM_SLOT_BACK && slot != SLOT_BACK) || (slot_flags == ITEM_SLOT_BELT && slot != SLOT_BELT))
		remove_paddles(user)
		update_icon()

/obj/item/defibrillator/item_action_slot_check(slot, mob/user)
	if(slot == user.getBackSlot())
		return 1

/obj/item/defibrillator/proc/remove_paddles(mob/user) //this fox the bug with the paddles when other player stole you the defib when you have the paddles equiped
	if(ismob(paddles.loc))
		var/mob/M = paddles.loc
		M.dropItemToGround(paddles, TRUE)
	return

/obj/item/defibrillator/Destroy()
	if(on)
		var/M = get(paddles, /mob)
		remove_paddles(M)
	QDEL_NULL(paddles)
	. = ..()
	update_icon()

/obj/item/defibrillator/proc/deductcharge(chrgdeductamt)
	if(cell)
		if(cell.charge < (paddles.revivecost+chrgdeductamt))
			powered = FALSE
			update_icon()
		if(cell.use(chrgdeductamt))
			update_icon()
			return TRUE
		else
			update_icon()
			return FALSE

/obj/item/defibrillator/proc/cooldowncheck(mob/user)
	spawn(50)
		if(cell)
			if(cell.charge >= paddles.revivecost)
				user.visible_message("<span class='notice'>[src] beeps: Unit ready.</span>")
				playsound(src, 'sound/machines/defib_ready.ogg', 50, 0)
			else
				user.visible_message("<span class='notice'>[src] beeps: Charge depleted.</span>")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		paddles.cooldown = FALSE
		paddles.update_icon()
		update_icon()

/obj/item/defibrillator/compact
	name = "compact defibrillator"
	desc = "A belt-equipped defibrillator that can be rapidly deployed."
	icon_state = "defibcompact"
	item_state = "defibcompact"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT

/obj/item/defibrillator/compact/item_action_slot_check(slot, mob/user)
	if(slot == user.getBeltSlot())
		return TRUE

/obj/item/defibrillator/compact/loaded/Initialize()
	. = ..()
	paddles = make_paddles()
	cell = new(src)
	update_icon()

/obj/item/defibrillator/compact/combat
	name = "combat defibrillator"
	desc = "A belt-equipped blood-red defibrillator that can be rapidly deployed. Does not have the restrictions or safeties of conventional defibrillators and can revive through space suits."
	combat = TRUE
	safety = FALSE

/obj/item/defibrillator/compact/combat/loaded/Initialize()
	. = ..()
	paddles = make_paddles()
	cell = new /obj/item/stock_parts/cell/infinite(src)
	update_icon()

/obj/item/defibrillator/compact/combat/loaded/attackby(obj/item/W, mob/user, params)
	if(W == paddles)
		paddles.unwield()
		toggle_paddles()
		update_icon()
		return

//paddles

/obj/item/twohanded/shockpaddles
	name = "defibrillator paddles"
	desc = "A pair of plastic-gripped paddles with flat metal surfaces that are used to deliver powerful electric shocks."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "defibpaddles0"
	item_state = "defibpaddles0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'

	force = 0
	throwforce = 6
	w_class = WEIGHT_CLASS_BULKY

	var/revivecost = 1000
	var/cooldown = FALSE
	var/busy = FALSE
	var/obj/item/defibrillator/defib
	var/req_defib = TRUE
	var/combat = FALSE //If it penetrates armor and gives additional functionality
	var/grab_ghost = FALSE
	var/tlimit = DEFIB_TIME_LIMIT * 10

	var/datum/component/mobhook

/obj/item/twohanded/shockpaddles/equipped(mob/user, slot)
	. = ..()
	if(req_defib)
		if (mobhook && mobhook.parent != user)
			QDEL_NULL(mobhook)
		if (!mobhook)
			mobhook = user.AddComponent(/datum/component/redirect, list(COMSIG_MOVABLE_MOVED = CALLBACK(src, .proc/check_range)))

/obj/item/twohanded/shockpaddles/Moved()
	. = ..()
	check_range()

/obj/item/twohanded/shockpaddles/proc/check_range()
	if(!req_defib)
		return
	if(!in_range(src,defib))
		var/mob/living/L = loc
		if(istype(L))
			to_chat(L, "<span class='warning'>[defib]'s paddles overextend and come out of your hands!</span>")
			L.temporarilyRemoveItemFromInventory(src,TRUE)
		else
			visible_message("<span class='notice'>[src] snap back into [defib].</span>")
			snap_back()

/obj/item/twohanded/shockpaddles/proc/recharge(var/time)
	if(req_defib || !time)
		return
	cooldown = TRUE
	update_icon()
	sleep(time)
	var/turf/T = get_turf(src)
	T.audible_message("<span class='notice'>[src] beeps: Unit is recharged.</span>")
	playsound(src, 'sound/machines/defib_ready.ogg', 50, 0)
	cooldown = FALSE
	update_icon()

/obj/item/twohanded/shockpaddles/New(mainunit)
	..()
	if(check_defib_exists(mainunit, src) && req_defib)
		defib = mainunit
		forceMove(defib)
		busy = FALSE
		update_icon()

/obj/item/twohanded/shockpaddles/update_icon()
	icon_state = "defibpaddles[wielded]"
	item_state = "defibpaddles[wielded]"
	if(cooldown)
		icon_state = "defibpaddles[wielded]_cooldown"
	if(iscarbon(loc))
		var/mob/living/carbon/C = loc
		C.update_inv_hands()

/obj/item/twohanded/shockpaddles/suicide_act(mob/user)
	user.visible_message("<span class='danger'>[user] is putting the live paddles on [user.p_their()] chest! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	if(req_defib)
		defib.deductcharge(revivecost)
	playsound(src, 'sound/machines/defib_zap.ogg', 50, 1, -1)
	return (OXYLOSS)

/obj/item/twohanded/shockpaddles/dropped(mob/user)
	if(!req_defib)
		return ..()
	if (mobhook)
		QDEL_NULL(mobhook)
	if(user)
		var/obj/item/twohanded/offhand/O = user.get_inactive_held_item()
		if(istype(O))
			O.unwield()
		to_chat(user, "<span class='notice'>The paddles snap back into the main unit.</span>")
		snap_back()
	return unwield(user)

/obj/item/twohanded/shockpaddles/proc/snap_back()
	if(!defib)
		return
	defib.on = FALSE
	forceMove(defib)
	defib.update_icon()

/obj/item/twohanded/shockpaddles/proc/check_defib_exists(mainunit, mob/living/carbon/M, obj/O)
	if(!req_defib)
		return TRUE //If it doesn't need a defib, just say it exists
	if (!mainunit || !istype(mainunit, /obj/item/defibrillator))	//To avoid weird issues from admin spawns
		qdel(O)
		return FALSE
	else
		return TRUE

/obj/item/twohanded/shockpaddles/attack(mob/M, mob/user)

	if(busy)
		return
	if(req_defib && !defib.powered)
		user.visible_message("<span class='notice'>[defib] beeps: Unit is unpowered.</span>")
		playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
		return
	if(!wielded)
		if(iscyborg(user))
			to_chat(user, "<span class='warning'>You must activate the paddles in your active module before you can use them on someone!</span>")
		else
			to_chat(user, "<span class='warning'>You need to wield the paddles in both hands before you can use them on someone!</span>")
		return
	if(cooldown)
		if(req_defib)
			to_chat(user, "<span class='warning'>[defib] is recharging!</span>")
		else
			to_chat(user, "<span class='warning'>[src] are recharging!</span>")
		return

	user.stop_pulling() //User has hands full, and we don't care about anyone else pulling on it, their problem. CLEAR!!

	if(user.a_intent == INTENT_DISARM)
		do_disarm(M, user)
		return

	if(!iscarbon(M))
		if(req_defib)
			to_chat(user, "<span class='warning'>The instructions on [defib] don't mention how to revive that...</span>")
		else
			to_chat(user, "<span class='warning'>You aren't sure how to revive that...</span>")
		return
	var/mob/living/carbon/H = M


	if(user.zone_selected != BODY_ZONE_CHEST)
		to_chat(user, "<span class='warning'>You need to target your patient's chest with [src]!</span>")
		return

	if(user.a_intent == INTENT_HARM)
		do_harm(H, user)
		return

	if((!req_defib && grab_ghost) || (req_defib && defib.grab_ghost))
		H.notify_ghost_cloning("Your heart is being defibrillated!")
		H.grab_ghost() // Shove them back in their body.
	else if(can_defib(H))
		H.notify_ghost_cloning("Your heart is being defibrillated. Re-enter your corpse if you want to be revived!", source = src)

	do_help(H, user)

/obj/item/twohanded/shockpaddles/proc/can_defib(mob/living/carbon/H) //Our code here is different than tg, if it breaks in testing; BUG_PROBABLE_CAUSE
	var/obj/item/organ/heart = H.getorgan(/obj/item/organ/heart)
	if(H.suiciding || H.hellbound || HAS_TRAIT(H, TRAIT_HUSK))
		return
	if((world.time - H.timeofdeath) > tlimit)
		return
	if((H.getBruteLoss() >= MAX_REVIVE_BRUTE_DAMAGE) || (H.getFireLoss() >= MAX_REVIVE_FIRE_DAMAGE))
		return
	if(!heart || (heart.organ_flags & ORGAN_FAILING))
		return
	var/obj/item/organ/brain/BR = H.getorgan(/obj/item/organ/brain)
	if(QDELETED(BR) || BR.brain_death || (BR.organ_flags & ORGAN_FAILING) || H.suiciding)
		return
	return TRUE

/obj/item/twohanded/shockpaddles/proc/shock_touching(dmg, mob/H)
	if(req_defib)
		if(defib.pullshocksafely && isliving(H.pulledby))
			H.visible_message("<span class='danger'>The defibrillator safely discharges the excessive charge into the floor!</span>")
	else
		var/mob/living/M = H.pulledby
		if(M.electrocute_act(30, src))
			M.visible_message("<span class='danger'>[M] is electrocuted by [M.p_their()] contact with [H]!</span>")
			M.emote("scream")

/obj/item/twohanded/shockpaddles/proc/do_disarm(mob/living/M, mob/living/user)
	if(req_defib && defib.safety)
		return
	if(!req_defib && !combat)
		return
	M.visible_message("<span class='danger'>[user] hastily places [src] on [M]'s chest!</span>", \
			"<span class='userdanger'>[user] hastily places [src] on [M]'s chest!</span>")
	busy = TRUE
	if(do_after(user, 10, target = M))
		M.visible_message("<span class='danger'>[user] zaps [M] with [src]!</span>", \
				"<span class='userdanger'>[user] zaps [M] with [src]!</span>")
		M.adjustStaminaLoss(50)
		M.Knockdown(100)
		M.updatehealth() //forces health update before next life tick
		playsound(src,  'sound/machines/defib_zap.ogg', 50, 1, -1)
		M.emote("gasp")
		log_combat(user, M, "stunned", src)
		busy = FALSE
		if(req_defib)
			defib.deductcharge(revivecost)
			cooldown = TRUE
	busy = FALSE
	update_icon()
	if(req_defib)
		defib.cooldowncheck(user)
	else
		recharge(60)

/obj/item/twohanded/shockpaddles/proc/do_harm(mob/living/carbon/H, mob/living/user)
	if(req_defib && defib.safety)
		return
	if(!req_defib && !combat)
		return
	user.visible_message("<span class='warning'>[user] begins to place [src] on [H]'s chest.</span>",
		"<span class='warning'>You overcharge the paddles and begin to place them onto [H]'s chest...</span>")
	busy = TRUE
	update_icon()
	if(do_after(user, 30, target = H))
		user.visible_message("<span class='notice'>[user] places [src] on [H]'s chest.</span>",
			"<span class='warning'>You place [src] on [H]'s chest and begin to charge them.</span>")
		var/turf/T = get_turf(defib)
		playsound(src, 'sound/machines/defib_charge.ogg', 50, 0)
		if(req_defib)
			T.audible_message("<span class='warning'>\The [defib] lets out an urgent beep and lets out a steadily rising hum...</span>")
		else
			user.audible_message("<span class='warning'>[src] let out an urgent beep.</span>")
		if(do_after(user, 30, target = H)) //Takes longer due to overcharging
			if(!H)
				busy = FALSE
				update_icon()
				return
			if(H && H.stat == DEAD)
				to_chat(user, "<span class='warning'>[H] is dead.</span>")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				busy = FALSE
				update_icon()
				return
			user.visible_message("<span class='boldannounce'><i>[user] shocks [H] with \the [src]!</span>", "<span class='warning'>You shock [H] with \the [src]!</span>")
			playsound(src, 'sound/machines/defib_zap.ogg', 100, 1, -1)
			playsound(src, 'sound/weapons/egloves.ogg', 100, 1, -1)
			H.emote("scream")
			shock_touching(45, H)
			if(H.can_heartattack() && !H.undergoing_cardiac_arrest())
				if(!H.stat)
					H.visible_message("<span class='warning'>[H] thrashes wildly, clutching at [H.p_their()] chest!</span>",
						"<span class='userdanger'>You feel a horrible agony in your chest!</span>")
				H.set_heartattack(TRUE)
			H.apply_damage(50, BURN, BODY_ZONE_CHEST)
			log_combat(user, H, "overloaded the heart of", defib)
			H.Knockdown(100)
			H.Jitter(100)
			if(req_defib)
				defib.deductcharge(revivecost)
				cooldown = TRUE
			busy = FALSE
			update_icon()
			if(!req_defib)
				recharge(60)
			if(req_defib && (defib.cooldowncheck(user)))
				return
	busy = FALSE
	update_icon()

/obj/item/twohanded/shockpaddles/proc/do_help(mob/living/carbon/H, mob/living/user)
	user.visible_message("<span class='warning'>[user] begins to place [src] on [H]'s chest.</span>", "<span class='warning'>You begin to place [src] on [H]'s chest...</span>")
	busy = TRUE
	update_icon()

	var/primetimer
	var/primetimer2
	var/deathtimer
	if(req_defib)
		primetimer = 30 - defib.primetime //I swear to god if I find shit like this elsewhere
		primetimer2 = 20 - defib.primetime
		deathtimer = DEFIB_TIME_LOSS * defib.timedeath
	else
		primetimer = 30
		primetimer2 = 20
		deathtimer = DEFIB_TIME_LOSS * 10

	if(do_after(user, primetimer, target = H)) //beginning to place the paddles on patient's chest to allow some time for people to move away to stop the process
		user.visible_message("<span class='notice'>[user] places [src] on [H]'s chest.</span>", "<span class='warning'>You place [src] on [H]'s chest.</span>")
		playsound(src, 'sound/machines/defib_charge.ogg', 75, 0)
		// patients rot when they are killed, and die when they are dead
		var/tplus = world.time - H.timeofdeath	//length of time spent dead
		var/tloss = deathtimer
		var/total_burn	= 0
		var/total_brute	= 0
		var/obj/item/organ/heart = H.getorgan(/obj/item/organ/heart)
		if(do_after(user, primetimer2, target = H)) //placed on chest and short delay to shock for dramatic effect, revive time is 5sec total
			for(var/obj/item/carried_item in H.contents)
				if(istype(carried_item, /obj/item/clothing/suit/space))
					if((!combat && !req_defib) || (req_defib && !defib.combat))
						user.audible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Patient's chest is obscured. Operation aborted.</span>")
						playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
						busy = FALSE
						update_icon()
						return
			if(H.stat == DEAD)
				H.visible_message("<span class='warning'>[H]'s body convulses a bit.</span>")
				playsound(src, "bodyfall", 50, 1)
				playsound(src, 'sound/machines/defib_zap.ogg', 75, 1, -1)
				total_brute	= H.getBruteLoss()
				total_burn	= H.getFireLoss()
				shock_touching(30, H)
				var/failed

				if (H.suiciding || (HAS_TRAIT(H, TRAIT_NOCLONE)))
					failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Recovery of patient impossible. Further attempts futile.</span>"
				else if (H.hellbound)
					failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's soul appears to be on another plane of existence.  Further attempts futile.</span>"
				else if (tplus > tlimit)
					failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Body has decayed for too long. Further attempts futile.</span>"
				else if (!heart)
					failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's heart is missing.</span>"
				else if (heart.organ_flags & ORGAN_FAILING)
					failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's heart too damaged.</span>"
				else if(total_burn >= 180 || total_brute >= 180)
					failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Severe tissue damage makes recovery of patient impossible via defibrillator. Further attempts futile.</span>"
				else if(H.get_ghost())
					failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - No activity in patient's brain. Further attempts may be successful.</span>"
				else
					var/obj/item/organ/brain/BR = H.getorgan(/obj/item/organ/brain)
					if(BR) //BUG_PROBABLE_CAUSE - slight difference between us and tg
						if(BR.organ_flags & ORGAN_FAILING)
							failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's brain tissue is damaged making recovery of patient impossible via defibrillator. Further attempts futile.</span>"
						if(BR.brain_death)
							failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's brain damaged beyond point of no return. Further attempts futile.</span>"
						if(H.suiciding || BR.brainmob?.suiciding)
							failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - No intelligence pattern can be detected in patient's brain. Further attempts futile.</span>"
					else
						failed = "<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed - Patient's brain is missing. Further attempts futile.</span>"


				if(failed)
					user.visible_message(failed)
					playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
				else
					//If the body has been fixed so that they would not be in crit when defibbed, give them oxyloss to put them back into crit
					if (H.health > HALFWAYCRITDEATH)
						H.adjustOxyLoss(H.health - HALFWAYCRITDEATH, 0)
					else
						var/overall_damage = total_brute + total_burn + H.getToxLoss() + H.getOxyLoss()
						var/mobhealth = H.health
						H.adjustOxyLoss((mobhealth - HALFWAYCRITDEATH) * (H.getOxyLoss() / overall_damage), 0)
						H.adjustToxLoss((mobhealth - HALFWAYCRITDEATH) * (H.getToxLoss() / overall_damage), 0)
						H.adjustFireLoss((mobhealth - HALFWAYCRITDEATH) * (total_burn / overall_damage), 0)
						H.adjustBruteLoss((mobhealth - HALFWAYCRITDEATH) * (total_brute / overall_damage), 0)
					H.updatehealth() // Previous "adjust" procs don't update health, so we do it manually.
					user.visible_message("<span class='notice'>[req_defib ? "[defib]" : "[src]"] pings: Resuscitation successful.</span>")
					playsound(src, 'sound/machines/defib_success.ogg', 50, 0)
					H.set_heartattack(FALSE)
					H.revive()
					H.emote("gasp")
					H.Jitter(100)
					SEND_SIGNAL(H, COMSIG_LIVING_MINOR_SHOCK)
					if(tplus > tloss)
						H.adjustOrganLoss(ORGAN_SLOT_BRAIN,  max(0, min(99, ((tlimit - tplus) / tlimit * 100))), 150)
					log_combat(user, H, "revived", defib)
					if(req_defib)
						if(defib.healdisk)
							H.heal_overall_damage(25, 25)
				if(req_defib)
					defib.deductcharge(revivecost)
					cooldown = 1
				update_icon()
				if(req_defib)
					defib.cooldowncheck(user)
				else
					recharge(60)
			else if (!H.getorgan(/obj/item/organ/heart))
				user.visible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Patient's heart is missing. Operation aborted.</span>")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
			else if(H.undergoing_cardiac_arrest())
				H.set_heartattack(FALSE)
				if(!(heart.organ_flags & ORGAN_FAILING))
					H.set_heartattack(FALSE)
					user.visible_message("<span class='notice'>[req_defib ? "[defib]" : "[src]"] pings: Patient's heart is now beating again.</span>")
				else
					user.visible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Resuscitation failed, heart damage detected.</span>")
				playsound(src, 'sound/machines/defib_zap.ogg', 50, 1, -1)


			else
				user.visible_message("<span class='warning'>[req_defib ? "[defib]" : "[src]"] buzzes: Patient is not in a valid state. Operation aborted.</span>")
				playsound(src, 'sound/machines/defib_failed.ogg', 50, 0)
	busy = FALSE
	update_icon()

/obj/item/defibrillator/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/disk/medical/defib_heal))
		if(healdisk)
			to_chat(user, "<span class='notice'>This unit is already upgraded with this disk!</span>")
			return TRUE
		to_chat(user, "<span class='notice'>You upgrade the unit with Heal upgrade disk!</span>")
		healdisk = TRUE
		return TRUE
	if(istype(I, /obj/item/disk/medical/defib_shock))
		if(pullshocksafely)
			to_chat(user, "<span class='notice'>This unit is already upgraded with this disk!</span>")
			return TRUE
		to_chat(user, "<span class='notice'>You upgrade the unit with Shock Safety upgrade disk!</span>")
		pullshocksafely = TRUE
		return TRUE
	if(istype(I, /obj/item/disk/medical/defib_speed))
		if(!primetime == initial(primetime))
			to_chat(user, "<span class='notice'>This unit is already upgraded with this disk!</span>")
			return TRUE
		to_chat(user, "<span class='notice'>You upgrade the unit with Speed upgrade disk!</span>")
		primetime = 20
		return TRUE
	if(istype(I, /obj/item/disk/medical/defib_decay))
		if(!timedeath == initial(timedeath))
			to_chat(user, "<span class='notice'>This unit is already upgraded with this disk!</span>")
			return TRUE
		to_chat(user, "<span class='notice'>You upgrade the unit with Longer Decay upgrade disk!</span>")
		timedeath = 20
		return TRUE
	return ..()

/obj/item/twohanded/shockpaddles/cyborg
	name = "cyborg defibrillator paddles"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "defibpaddles0"
	item_state = "defibpaddles0"
	req_defib = FALSE

/obj/item/twohanded/shockpaddles/cyborg/attack(mob/M, mob/user)
	if(iscyborg(user))
		var/mob/living/silicon/robot/R = user
		if(R.emagged)
			combat = TRUE
		else
			combat = FALSE
	else
		combat = FALSE

	. = ..()

/obj/item/twohanded/shockpaddles/syndicate
	name = "syndicate defibrillator paddles"
	desc = "A pair of paddles used to revive deceased operatives. It possesses both the ability to penetrate armor and to deliver powerful shocks offensively."
	combat = TRUE
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "defibpaddles0"
	item_state = "defibpaddles0"
	req_defib = FALSE

///////////////////////////////////////////
/////////Defibrillator Disks//////////////
///////////////////////////////////////////

/obj/item/disk/medical
	name = "Defibrillator Upgrade Disk"
	desc = "A blank upgrade disk, made for a defibrillator"
	icon = 'modular_citadel/icons/obj/defib_disks.dmi'
	icon_state = "upgrade_disk"
	item_state = "heal_disk"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/disk/medical/defib_heal
	name = "Defibrillator Healing Disk"
	desc = "An upgrade which increases the healing power of the defibrillator"
	icon_state = "heal_disk"
	materials = list(MAT_METAL=16000, MAT_GLASS = 18000, MAT_GOLD = 6000, MAT_SILVER = 6000)

/obj/item/disk/medical/defib_shock
	name = "Defibrillator Anti-Shock Disk"
	desc = "A safety upgrade that guarantees only the patient will get shocked"
	icon_state = "zap_disk"
	materials = list(MAT_METAL=16000, MAT_GLASS = 18000, MAT_GOLD = 6000, MAT_SILVER = 6000)

/obj/item/disk/medical/defib_decay
	name = "Defibrillator Body-Decay Extender Disk"
	desc = "An upgrade allowing the defibrillator to work on more decayed bodies"
	icon_state = "body_disk"
	materials = list(MAT_METAL=16000, MAT_GLASS = 18000, MAT_GOLD = 16000, MAT_SILVER = 6000, MAT_TITANIUM = 2000)

/obj/item/disk/medical/defib_speed
	name = "Defibrillator Fast Charge Disk"
	desc = "An upgrade to the defibrillator capacitors, which let it charge faster"
	icon_state = "fast_disk"
	materials = list(MAT_METAL=16000, MAT_GLASS = 8000, MAT_GOLD = 26000, MAT_SILVER = 26000)

#undef HALFWAYCRITDEATH
