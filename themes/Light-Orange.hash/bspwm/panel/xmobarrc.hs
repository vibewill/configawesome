Config {
       font = "xft:Dejavu Sans:size=10"
       , additionalFonts = [ "xft:Font Awesome 5 Pro:size=9","xft:Dejavu Sans:size=9","xft:Dejavu Sans:size=13","xft:Robot Crush:size=10","xft:Font Awesome 5 Pro:size=10" ]
       , allDesktops = True
    -- , textOffset = 23
       , bgColor = "#F3E3BD"
       , fgColor = "#0c0c0c"
    -- , position = Static { xpos = 0 , ypos = 0, width = 1367, height = 22 }
       , position = TopSize L 100 10
    -- , border = FullBM 0
    -- , borderColor =  "#fff"
    -- , borderWidth = 0
       , commands = [ Run Cpu [ "--template", "<fc=#f57900><fn=1></fn></fc><fn=2> <total></fn><fn=4>%</fn>"
                              , "--Low","3"
                              , "--High","80"
                              , "--low","#0c0c0c"
                              , "--normal","#0c0c0c"
                              , "--high","#fb4934"] 50

                    , Run Memory ["-t","<fc=#f57900><fn=1></fn></fc><fn=2> <usedratio></fn><fn=4>%</fn>"
                                 ,"-H","80"
                                 ,"-L","10"
                                 ,"-l","#0c0c0c"
                                 ,"-n","#0c0c0c"
                                 ,"-h","#fb4934"] 50

                    , Run Date "<fc=#f57900><fn=1></fn></fc><fn=2> %I:%M</fn>" "date" 300
                    , Run DynNetwork ["-t","<fc=#f57900><fn=1></fn></fc><fn=2> <rx> </fn><fc=#f57900><fn=1></fn></fc><fn=2> <tx></fn>"
                                     ,"-H","200"
                                     ,"-L","10"
                                     ,"-h","#0c0c0c"
                                     ,"-l","#0c0c0c"
                                     ,"-n","#0c0c0c"] 50
                   

                    , Run ThermalZone 0 ["-t","<fn=2><temp></fn><fn=4>°</fn>"
                                   , "-L", "30"
                                   , "-H", "65"
                                   , "-l", "#0c0c0c"
                                   , "-n", "#0c0c0c"
                                   , "-h", "#fb4934"] 50

				 -- , Run ComX "iwgetid" ["-r"] "N/A" "wifi" 30
					, Run CommandReader "sh ~/.config/bspwm/panel/wifi.sh -a" "wifi"
					, Run CommandReader "amixer get Master | awk -F'[]%[]' '/%/ { print $2 }' | head -n 1 > /tmp/volume ; tail -f -q -n +0 /tmp/volume 2> /dev/null" "vol"
          , Run CommandReader "~/.config/bspwm/panel/workspaces_bspwm" "workspaces"
          , Run Com ".config/bspwm/panel/trayer-padding.sh" [] "trayer" 20
                    ]
       , sepChar = "$"
       , alignSep = "}{"
       , template = "<fc=#0c0c0c><fn=1>$trayer$<fc=#f9cda2></fc> $date$ <fc=#f9cda2></fc> <fc=#f57900><fn=1></fn></fc><fn=2> $wifi$</fn> $dynnetwork$ <fc=#f9cda2></fc> <fc=#f57900> </fc><fn=2>$vol$</fn><fn=4>%</fn> <fc=#f9cda2></fc> <fc=#f57900><fn=1> </fn></fc><fn=2>$thermal0$</fn> <fc=#f9cda2></fc> $memory$ <fc=#f9cda2></fc> $cpu$ </fn></fc> }{ <fn=1>$workspaces$ </fn>"
       }
