
boolean fillInitialStomach()
{
    if(my_fullness() != 0)
    {
        return false;
    }
    if(item_amount($item[whet stone]) > 1)
    {
        use(1, $item[whet stone]);
    }
    
    cli_execute('acquire 1 milk of magnesium');
    use(1, $item[milk of magnesium]);
    eat(1, $item[spaghetti breakfast]);

    if(item_amount($item[blueberry muffin]) > 0)
    {
        eat(1, $item[blueberry muffin]);
    }
    if(item_amount($item[boris's bread]) == 0)
    {
        cli_execute('acquire 1 boris bread');
    }
    eat(1, $item[boris's bread]);

    if(item_amount($item[jumping horseradish]) == 0)
    {
        cli_execute('acquire 1 jumping horseradish');
    }
    eat(1, $item[jumping horseradish]);
    if(item_amount($item[glass of raw eggs]) > 0)
    {
        eat(1, $item[glass of raw eggs]);
    }



    return true;
}

boolean fillInitialLiver()
{
    if(item_amount($item[mime army shotglass]) != 0 && !get_property('_mimeArmyShotglassUsed').to_boolean())
    {
        drink(1, $item[splendid martini]);
    }
    if(have_effect($effect[ode to booze]) == 0)
    {
        use_skill(1, $skill[the ode to booze]);
    }
    if(item_amount($item[dirt julep]) > 0)
    {
        drink(1, $item[dirt julep]);
    }
    if(shop_amount($item[ambitious turkey]) > 0) 
    {
        refresh_shop(); 
        take_shop(1, $item[ambitious turkey]);
    }
    if(item_amount($item[ambitious turkey]) > 0)
    {
        drink(1, $item[ambitious turkey]);
    }
    if(item_amount($item[High-end ginger wine]) > 0)
    {
        drink(1, $item[High-end ginger wine]);
    }
    return true;
}

boolean fillSpleen()
{
    if(item_amount($item[body spradium]) > 0)
    {
        chew(1, $item[body spradium]);
    }
    if(item_amount($item[beggin' cologne]) > 0)
    {
        chew(1, $item[beggin' cologne]);
    }
    while(my_spleen_use() < spleen_limit() && have_effect($effect[Synthesis: Greed]) < 600)
    {
        cli_execute('synthesize greed');
    }
    cli_execute('acquire 3 mojo filter; use 3 mojo filter;');
    if(shop_amount($item[transdermal smoke patch]) > 2)
    {
        refresh_shop(); 
        take_shop(3, $item[transdermal smoke patch]);
    }
    if(item_amount($item[transdermal smoke patch]) > 0)
    {
        while(my_spleen_use() < spleen_limit() && item_amount($item[transdermal smoke patch]) > 0)
        {
            chew(1, $item[transdermal smoke patch]);
        }
    }
    return true;
}


void main()
{
    fillSpleen();
    fillInitialStomach();
    fillInitialLiver();
}


/*
use 1 LOV Extraterrestrial Chocolate

use 1 chocolate seal-clubbing club
use 1 chocolate seal-clubbing club

use 1 essential tofu

> ===== SHOTGLASS DIET =====

drink 1 splendid martini

> ===== FULL DIET =====

> 1 (max 1) august scepter value: 0 price: 0
> 3 (max 3) designer sweatpants value: 0 price: 0
> 1 (max 1) synthetic dog hair pill value: 0 price: 250
> 3 (max 3) mojo filter value: 0 price: 21900
> 1 (max 1) distention pill value: 0 price: 250

> 1 (max 1) pocket wish:Refined Palate value: 0 price: 49000

> 1 (max 1) Mr. Burnsger helpers: mini kiwi aioli value: 192000 price: 100900
> 1 (max 1) glass of raw eggs helpers: mini kiwi aioli value: 45000 price: 5900
> 12 (max 12) jumping horseradish(barf) helpers: mini kiwi aioli value: 633000 (additional value: 13750) price: 83292
> 24 Sacramento wine value: 1080000 price: 24840
> 1 (max 1) high-end ginger wine(barf) value: 112125 (additional value: 4125) price: 0
> 18 (max 20) Rethinking Candy(barf) value: 445500 (additional value: 24750) price: 0


To consider:

Spaghetti Breakfast
if(shop_amount($item[ambitious turkey] > 0) {refresh_shop(); take_shop(1, $item[ambitious turkey])}
Ambitious Turkey
Dirt Julep

Boris''s Bread



Food

Drink
Dirt Julep
High-end ginger wine
Ambitious Turkey

Spleen
if have - body spradium
if have - beggin' col
Synthesis-Greed



*/


