/*
use 1 LOV Extraterrestrial Chocolate
You gain 3 Adventures
Preference _loveChocolatesUsed changed from 0 to 1
Preference _concoctionDatabaseRefreshes changed from 864 to 865
> Trying to acquire 1 chocolate seal-clubbing clubs; max price 18000.

use 1 chocolate seal-clubbing club
You gain 3 Adventures
Preference _chocolatesUsed changed from 0 to 1
Preference _concoctionDatabaseRefreshes changed from 865 to 866
> Trying to acquire 1 chocolate seal-clubbing clubs; max price 12000.

use 1 chocolate seal-clubbing club
You gain 2 Adventures
Preference _chocolatesUsed changed from 1 to 2
Preference _concoctionDatabaseRefreshes changed from 866 to 867
> Skipping fancy chocolate sculpture; too expensive (98749 > 35000).
> Trying to acquire 1 blobs of essential tofu; max price 30000.

use 1 essential tofu
You gain 6 Adventures
Preference _essentialTofuUsed changed from false to true
Preference _concoctionDatabaseRefreshes changed from 867 to 868
Preference nextAdventure changed from The Sunken Party Yacht to Barf Mountain
> ===== FULL DIET =====
> Planning to fight 27 Witchess Knight and run 738 adventures
> 1 (max 1) august scepter value: 0 price: 0
> 3 (max 3) designer sweatpants value: 0 price: 0
> 1 (max 1) pocket wish:Refined Palate value: 0 price: 49950
> 3 (max 3) mojo filter value: 0 price: 17997
> 13 (max 15) jumping horseradish(barf) helpers: Special Seasoning value: 685750 (additional value: 13750) price: 79898
> 20 Sacramento wine value: 900000 price: 14900
> 15 (max 25) Rethinking Candy(barf) value: 371250 (additional value: 24750) price: 0
> Assuming MPA of 6000, Total Cost 162745, Total Value 1957000, Net Value 1794255
> Trying to acquire 13 jars of Special Seasoning; max price 6000.
Preference autoBuyPriceLimit changed from 100000 to 6000
mallsearch "Special Seasoning"



*/

boolean eatWithHelper(item it)
{
    if(item_amount($item[whet stone]) > 1)
    {
        use(1, $item[whet stone]);
    }
    if(mall_price($item[special seasoning]) < get_property('valueOfAdventure').to_int() && item_amount($item[special seasoning]) == 0)
    {
        if(closet_amount($item[special seasoning]))
        {
            take_closet(1, $item[special seasoning]);
        }
        else if(shop_amount($item[special seasoning]) > 0)
        {
            take_shop(1, $item[special seasoning]);
        }
        else 
        {
            buy(1, $item[special seasoning]);
        }
    }
    if(mall_price($item[kiwi aioli]) < get_property('valueOfAdventure').to_int() && item_amount($item[kiwi aioli]) == 0)
    {
        if(closet_amount($item[kiwi aioli]))
        {
            take_closet(1, $item[kiwi aioli]);
        }
        else if(shop_amount($item[kiwi aioli]) > 0)
        {
            take_shop(1, $item[kiwi aioli]);
        }
        else 
        {
            buy(1, $item[kiwi aioli]);
        }
        use(1, $item[kiwi aioli]);
    }
    if(!get_property('_milkOfMagnesiumUsed').to_boolean() && !get_property('milkOfMagnesiumActive').to_boolean())
    {
        cli_execute('acquire 1 milk of magnesium');
        use(1, $item[milk of magnesium]);
    }
    eat(1, it);
}


boolean fillInitialStomach()
{
    //Making sure we eat our breakfast, and get the +meat buffs we want.
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
    if(item_amount($item[boris's bread]) == 0 && shop_amount($item[yeast of boris]) > 1) 
    {
        refresh_shop(); 
        take_shop(2, $item[yeast of boris]);
        cli_execute('make 1 boris bread');
    }
    eat(1, $item[boris's bread]);

    if(item_amount($item[jumping horseradish]) == 0 && shop_amount($item[jumping horseradish]) > 1)
    {
        refresh_shop(); 
        take_shop(1, $item[jumping horseradish]);
    }
    eat(1, $item[jumping horseradish]);
    if(item_amount($item[roasted vegetable foccaccia]) == 0)
    {
        if(item_amount($item[boris's bread]) == 0 && shop_amount($item[yeast of boris]) > 1) 
        {
            refresh_shop(); 
            take_shop(2, $item[yeast of boris]);
            cli_execute('make 1 boris bread');
        }
        if(item_amount($item[roasted vegetable of jarlsberg]) == 0 && shop_amount($item[vegetable of jarlsberg]) > 1) 
        {
            refresh_shop(); 
            take_shop(2, $item[vegetable of jarlsberg]);
            cli_execute('make 1 roasted vegetable of jarlsberg');
        }    
    }
    eat(1, $item[roasted vegetable foccaccia]);
    
    return true;
}

boolean fillInitialLiver()
{
    if(item_amount($item[mime army shotglass]) != 0 && !get_property('_mimeArmyShotglassUsed').to_boolean())
    {
        if(item_amount($item[splendid martini]) == 0 && shop_amount($item[splendid martini]) > 0) 
        {
            refresh_shop(); 
            take_shop(1, $item[splendid martini]);
        }
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
    if(item_amount($item[ambitious turkey]) == 0 && shop_amount($item[ambitious turkey]) > 0) 
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

    while(get_property('_sweatOutSomeBoozeUsed').to_int() < 3
        && get_property('sweat').to_int() >= 25
        && my_inebriety() > 0)
    {
        equip($item[designer sweatpants]);
        use_skill(1, $skill[sweat out some booze]);
    }
    return true;
}

boolean fillSpleen()
{
    if(my_spleen_use() == spleen_limit())
    {
        return false;
    }
    if(my_spleen_use() > 0)
        return false;
    
    if(item_amount($item[body spradium]) > 0 && spleen_limit()-my_spleen_use() >= 1)
    {
        chew(1, $item[body spradium]);
    }
    if(item_amount($item[beggin' cologne]) > 0 && spleen_limit()-my_spleen_use() >= 1)
    {
        chew(1, $item[beggin' cologne]);
    }
    if(my_spleen_use() < spleen_limit() && have_effect($effect[Synthesis: Greed]) < 600)
    {
        cli_execute('synthesize greed');
    }
    /*
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
    */
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


