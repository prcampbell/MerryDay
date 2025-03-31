if monstername crate
    if hasskill transcendent olfaction
        skill transcendent olfaction
    endif
    if hasskill 7326 # Switch Enemy
        skill 7326
    endif
endif

if monstername crate
 if hasskill macrometeor
  skill macrometeor
 endif
endif
if !monstername cockroach && hasskill Back-Up to your Last Enemy
   skill Back-Up to your Last Enemy
endif
if (hascombatitem spooky putty sheet && hascombatitem rain-doh black box) && monstername cockroach
		use spooky putty sheet, rain-doh black box
	endif
if monstername cockroach
    if hasskill 7485 #habitat
        skill 7485
    endif
    if hasskill 7526 #Purple Candle
        skill 7526
    endif
endif
if hasskill summon hobo underling
    skill summon hobo underling
endif
if hasskill Ask the hobo to tell you a joke
    skill Ask the hobo to tell you a joke
endif
if hasskill sing along
    skill sing along
endif
if hasskill become a wolf
    skill become a wolf
endif
if hasskill Bowl Straight Up
    skill Bowl Straight Up
endif
if hasskill Micrometeorite
    skill Micrometeorite
endif
if hascombatitem time-spinner
    use time-spinner
endif
if hascombatitem rain-doh indigo cup
    use rain-doh indigo cup
endif
if hasskill pocket crumbs
    skill pocket crumbs
endif
if hasskill furious wallop
    skill furious wallop
endif
while !hppercentbelow 25
    attack
endwhile