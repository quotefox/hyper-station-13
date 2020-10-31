/obj/item/reagent_containers/food/snacks/store/cake
	icon = 'icons/obj/food/piecake.dmi'
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/plain
	slices_num = 5
	bitesize = 3
	volume = 80
	list_reagents = list("nutriment" = 20, "vitamin" = 5)
	tastes = list("cake" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice
	icon = 'icons/obj/food/piecake.dmi'
	trash = /obj/item/trash/plate
	list_reagents = list("nutriment" = 4, "vitamin" = 1)
	customfoodfilling = 0 //to avoid infinite cake-ception
	tastes = list("cake" = 1)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/plain
	name = "plain cake"
	desc = "A plain cake, not a lie."
	icon_state = "plaincake"
	custom_food_type = /obj/item/reagent_containers/food/snacks/customizable/cake
	bonus_reagents = list("nutriment" = 10, "vitamin" = 2)
	tastes = list("sweetness" = 2,"cake" = 5)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/plain
	name = "plain cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "plaincake_slice"
	filling_color = "#FFD700"
	customfoodfilling = 1
	tastes = list("sweetness" = 2,"cake" = 5)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/carrot
	name = "carrot cake"
	desc = "A favorite desert of a certain wascally wabbit. Not a lie."
	icon_state = "carrotcake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/carrot
	slices_num = 5
	bonus_reagents = list("nutriment" = 3, "oculine" = 5, "vitamin" = 10)
	list_reagents = list("nutriment" = 20, "oculine" = 10, "vitamin" = 5)
	tastes = list("cake" = 5, "sweetness" = 2, "carrot" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/carrot
	name = "carrot cake slice"
	desc = "Carrotty slice of Carrot Cake, carrots are good for your eyes! Also not a lie."
	icon_state = "carrotcake_slice"
	filling_color = "#FFA500"
	list_reagents = list("nutriment" = 4, "oculine" = 2, "vitamin" = 1)
	tastes = list("cake" = 5, "sweetness" = 2, "carrot" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/brain
	name = "brain cake"
	desc = "A squishy cake-thing."
	icon_state = "braincake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/brain
	slices_num = 5
	bonus_reagents = list("nutriment" = 5, "mannitol" = 10, "vitamin" = 10)
	list_reagents = list("nutriment" = 20, "mannitol" = 10, "vitamin" = 5)
	tastes = list("cake" = 5, "sweetness" = 2, "brains" = 1)
	foodtype = GRAIN | DAIRY | MEAT | GROSS | SUGAR


/obj/item/reagent_containers/food/snacks/cakeslice/brain
	name = "brain cake slice"
	desc = "Lemme tell you something about prions. THEY'RE DELICIOUS."
	icon_state = "braincakeslice"
	filling_color = "#FF69B4"
	list_reagents = list("nutriment" = 4, "mannitol" = 2, "vitamin" = 1)
	tastes = list("cake" = 5, "sweetness" = 2, "brains" = 1)
	foodtype = GRAIN | DAIRY | MEAT | GROSS | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/cheese
	name = "cheese cake"
	desc = "DANGEROUSLY cheesy."
	icon_state = "cheesecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/cheese
	slices_num = 5
	bonus_reagents = list("vitamin" = 10)
	tastes = list("cake" = 4, "cream cheese" = 3)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice/cheese
	name = "cheese cake slice"
	desc = "Slice of pure cheestisfaction."
	icon_state = "cheesecake_slice"
	filling_color = "#FFFACD"
	tastes = list("cake" = 4, "cream cheese" = 3)
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/orange
	name = "orange cake"
	desc = "A cake with added orange."
	icon_state = "orangecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/orange
	slices_num = 5
	bonus_reagents = list("nutriment" = 3, "vitamin" = 10)
	tastes = list("cake" = 5, "sweetness" = 2, "oranges" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/orange
	name = "orange cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "orangecake_slice"
	filling_color = "#FFA500"
	tastes = list("cake" = 5, "sweetness" = 2, "oranges" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/lime
	name = "lime cake"
	desc = "A cake with added lime."
	icon_state = "limecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/lime
	slices_num = 5
	bonus_reagents = list("nutriment" = 3, "vitamin" = 10)
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/lime
	name = "lime cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "limecake_slice"
	filling_color = "#00FF00"
	tastes = list("cake" = 5, "sweetness" = 2, "unbearable sourness" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/lemon
	name = "lemon cake"
	desc = "A cake with added lemon."
	icon_state = "lemoncake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/lemon
	slices_num = 5
	bonus_reagents = list("nutriment" = 3, "vitamin" = 10)
	tastes = list("cake" = 5, "sweetness" = 2, "sourness" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/lemon
	name = "lemon cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "lemoncake_slice"
	filling_color = "#FFEE00"
	tastes = list("cake" = 5, "sweetness" = 2, "sourness" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/chocolate
	name = "chocolate cake"
	desc = "A cake with added chocolate."
	icon_state = "chocolatecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/chocolate
	slices_num = 5
	bonus_reagents = list("nutriment" = 3, "vitamin" = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "chocolate" = 4)
	foodtype = GRAIN | DAIRY | JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/chocolate
	name = "chocolate cake slice"
	desc = "Just a slice of cake, it is enough for everyone."
	icon_state = "chocolatecake_slice"
	filling_color = "#A0522D"
	tastes = list("cake" = 5, "sweetness" = 1, "chocolate" = 4)
	foodtype = GRAIN | DAIRY | JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/birthday
	name = "birthday cake"
	desc = "Happy Birthday little clown..."
	icon_state = "birthdaycake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/birthday
	slices_num = 5
	bonus_reagents = list("nutriment" = 7, "sprinkles" = 10, "vitamin" = 5)
	list_reagents = list("nutriment" = 20, "sprinkles" = 10, "vitamin" = 5)
	tastes = list("cake" = 5, "sweetness" = 1)
	foodtype = GRAIN | DAIRY | JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/birthday
	name = "birthday cake slice"
	desc = "A slice of your birthday."
	icon_state = "birthdaycakeslice"
	filling_color = "#DC143C"
	list_reagents = list("nutriment" = 4, "sprinkles" = 2, "vitamin" = 1)
	tastes = list("cake" = 5, "sweetness" = 1)
	foodtype = GRAIN | DAIRY | JUNKFOOD | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/apple
	name = "apple cake"
	desc = "A cake centred with Apple."
	icon_state = "applecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/apple
	slices_num = 5
	bonus_reagents = list("nutriment" = 3, "vitamin" = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/apple
	name = "apple cake slice"
	desc = "A slice of heavenly cake."
	icon_state = "applecakeslice"
	filling_color = "#FF4500"
	tastes = list("cake" = 5, "sweetness" = 1, "apple" = 1)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/custom
	name = "cake slice"
	icon_state = "plaincake_slice"
	filling_color = "#FFFFFF"
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/slimecake
	name = "Slime cake"
	desc = "A cake made of slimes. Probably not electrified."
	icon_state = "slimecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/slimecake
	bonus_reagents = list("nutriment" = 1, "vitamin" = 3)
	tastes = list("cake" = 5, "sweetness" = 1, "slime" = 1)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/slimecake
	name = "slime cake slice"
	desc = "A slice of slime cake."
	icon_state = "slimecake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 5, "sweetness" = 1, "slime" = 1)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/pumpkinspice
	name = "pumpkin spice cake"
	desc = "A hollow cake with real pumpkin."
	icon_state = "pumpkinspicecake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/pumpkinspice
	bonus_reagents = list("nutriment" = 3, "vitamin" = 5)
	tastes = list("cake" = 5, "sweetness" = 1, "pumpkin" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/pumpkinspice
	name = "pumpkin spice cake slice"
	desc = "A spicy slice of pumpkin goodness."
	icon_state = "pumpkinspicecakeslice"
	filling_color = "#FFD700"
	tastes = list("cake" = 5, "sweetness" = 1, "pumpkin" = 1)
	foodtype = GRAIN | DAIRY | VEGETABLES | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/bsvc // blackberry strawberries vanilla cake
	name = "blackberry and strawberry vanilla cake"
	desc = "A plain cake, filled with assortment of blackberries and strawberries!"
	icon_state = "blackbarry_strawberries_cake_vanilla_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/bsvc
	bonus_reagents = list("nutriment" = 14, "vitamin" = 4)
	tastes = list("blackbarry" = 2, "strawberries" = 2, "vanilla" = 2, "sweetness" = 2, "cake" = 3)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/bsvc
	name = "blackberry and strawberry vanilla cake slice"
	desc = "Just a slice of cake  filled with assortment of blackberries and strawberries!"
	icon_state = "blackbarry_strawberries_cake_vanilla_slice"
	filling_color = "#FFD700"
	tastes = list("blackbarry" = 2, "strawberries" = 2, "vanilla" = 2, "sweetness" = 2,"cake" = 3)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/bscc // blackbarry strawberries chocolate cake
	name = "blackberry and strawberry chocolate cake"
	desc = "A plain cake, filled with assortment of blackberries and strawberries!"
	icon_state = "blackbarry_strawberries_cake_coco_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/bscc
	bonus_reagents = list("nutriment" = 14, "vitamin" = 4, "cocoa" = 5)
	tastes = list("blackberry" = 2, "strawberries" = 2, "chocolate" = 2, "sweetness" = 2,"cake" = 3)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/bscc
	name = "blackberry and strawberry chocolate cake slice"
	desc = "Just a slice of cake  filled with assortment of blackberries and strawberries!"
	icon_state = "blackbarry_strawberries_cake_coco_cake_slice"
	filling_color = "#FFD700"
	tastes = list("blackberry" = 2, "strawberries" = 2, "chocolate" = 2, "sweetness" = 2,"cake" = 3)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/store/cake/holy_cake
	name = "angel food cake"
	desc = "A cake made for angels and chaplains alike! Contains holy water."
	icon_state = "holy_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/holy_cake_slice
	bonus_reagents = list("nutriment" = 1, "vitamin" = 3, "holy_water" = 10)
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)
	foodtype = GRAIN | DAIRY | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/holy_cake_slice
	name = "angel food cake slice"
	desc = "A slice of heavenly cake."
	icon_state = "holy_cake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 5, "sweetness" = 1, "clouds" = 1)
	foodtype = GRAIN | DAIRY | SUGAR

obj/item/reagent_containers/food/snacks/store/cake/pound_cake
	name = "pound cake"
	desc = "A condensed cake made for filling people up quickly."
	icon_state = "pound_cake"
	slices_num = 7 //Its ment to feed the party
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/pound_cake_slice
	bonus_reagents = list("nutriment" = 60)
	tastes = list("cake" = 5, "sweetness" = 1, "batter" = 1)
	foodtype = GRAIN | DAIRY | SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/cakeslice/pound_cake_slice
	name = "pound cake slice"
	desc = "A slice of condensed cake made for filling people up quickly."
	icon_state = "pound_cake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 5, "sweetness" = 5, "batter" = 1)
	foodtype = GRAIN | DAIRY | SUGAR | JUNKFOOD

/obj/item/reagent_containers/food/snacks/store/cake/hardware_cake
	name = "hardware cake"
	desc = "A cake that is made with electronic boards and leaks acid..."
	icon_state = "hardware_cake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/hardware_cake_slice
	bonus_reagents = list("sacid" = 15, "oil" = 15)
	tastes = list("acid" = 1, "metal" = 1, "regret" = 10)
	foodtype = GRAIN | GROSS

/obj/item/reagent_containers/food/snacks/cakeslice/hardware_cake_slice
	name = "hardware cake slice"
	desc = "A slice of electronic boards and some acid."
	icon_state = "hardware_cake_slice"
	filling_color = "#00FFFF"
	tastes = list("acid" = 1, "metal" = 1, "regret" = 10)
	foodtype = GRAIN | GROSS

/obj/item/reagent_containers/food/snacks/store/cake/vanilla_cake
	name = "vanilla cake"
	desc = "A vanilla frosted cake."
	icon_state = "vanillacake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/vanilla_slice
	bonus_reagents = list("sugar" = 15, "vanilla" = 15)
	tastes = list("caje" = 1, "sugar" = 1, "vanilla" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice/vanilla_slice
	name = "vanilla cake slice"
	desc = "A slice of vanilla frosted cake."
	icon_state = "vanillacake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 1, "sugar" = 1, "vanilla" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/clown_cake
	name = "clown cake"
	desc = "A funny cake with a clown face on it."
	icon_state = "clowncake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/clown_slice
	bonus_reagents = list("sugar" = 15, "laugher" = 15)
	tastes = list("cake" = 1, "sugar" = 1, "joy" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice/clown_slice
	name = "clown cake slice"
	desc = "A slice of bad jokes, and silly props."
	icon_state = "clowncake_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 1, "sugar" = 1, "joy" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/peach_cake
	name = "peach cake"
	desc = "A peach filled cake."
	icon_state = "peachcake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/peach_slice
	bonus_reagents = list("sugar" = 5, "peachjuice" = 15)
	tastes = list("cake" = 1, "sugar" = 1, "peachjuice" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/cakeslice/peach_slice
	name = "peach cake slice"
	desc = "A slice of peach cake."
	icon_state = "peach_slice"
	filling_color = "#00FFFF"
	tastes = list("cake" = 1, "sugar" = 1, "peachjuice" = 10)
	foodtype = GRAIN | SUGAR | DAIRY

/obj/item/reagent_containers/food/snacks/store/cake/trumpet
	name = "spaceman's cake"
	desc = "A spaceman's trumpet frosted cake."
	icon_state = "trumpetcake"
	slice_path = /obj/item/reagent_containers/food/snacks/cakeslice/trumpet
	bonus_reagents = list("polypyr" = 15, "cream" = 5, "vitamin" = 5, "berryjuice" = 5)
	filling_color = "#7A3D80"
	tastes = list("cake" = 4, "violets" = 2, "jam" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR

/obj/item/reagent_containers/food/snacks/cakeslice/trumpet
	name = "spaceman's cake"
	desc = "A spaceman's trumpet frosted cake."
	icon_state = "trumpetcakeslice"
	filling_color = "#7A3D80"
	tastes = list("cake" = 4, "violets" = 2, "jam" = 2)
	foodtype = GRAIN | DAIRY | FRUIT | SUGAR
