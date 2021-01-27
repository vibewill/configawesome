Config {
       font = "xft:Dejavu Sans:size=10"
       , additionalFonts = [ "xft:Font Awesome 5 Pro:size=9","xft:Dejavu Sans:size=9","xft:Dejavu Sans:size=13","xft:Robot Crush:size=10","xft:Font Awesome 5 Pro:size=10" ]
       , allDesktops = True
    -- , textOffset = 23
       , bgColor = "#0c0e14"
       , fgColor = "#7e57c2"
    -- , position = Static { xpos = 0 , ypos = 0, width = 1367, height = 22 }
       , position = TopSize L 100 10
    -- , border = FullBM 0
    -- , borderColor =  "#fff"
    -- , borderWidth = 0
       , commands = [ Run Cpu [ "--template", "<fc=#c50ed2><fn=1></fn></fc><fn=2> <total></fn><fn=4><fc=#02b4cc>%</fc></fn>"
                              , "--Low","3"
                              , "--High","80"
                              , "--low","#7e57c2"
                              , "--normal","#7e57c2"
                              , "--high","#fb4934"] 50

                    , Run Memory ["-t","<fc=#c50ed2><fn=1></fn></fc><fn=2> <usedratio></fn><fn=4><fc=#02b4cc>%</fc></fn>"
                                 ,"-H","80"
                                 ,"-L","10"
                                 ,"-l","#7e57c2"
                                 ,"-n","#7e57c2"
                                 ,"-h","#fb4934"] 50

                    , Run Date "<fc=#c50ed2><fn=1></fn></fc><fn=2> %I:%M</fn>" "date" 300
                    , Run DynNetwork ["-t","<fc=#02b4cc><fn=1></fn></fc><fn=2> <rx> </fn><fc=#02b4cc><fn=1></fn></fc><fn=2> <tx></fn>"
                                     ,"-H","200"
                                     ,"-L","10"
                                     ,"-h","#7e57c2"
                                     ,"-l","#7e57c2"
                                     ,"-n","#7e57c2"] 50
                   

                    , Run ThermalZone 0 ["-t","<fn=2><temp></fn><fn=4><fc=#02b4cc>°</fc></fn>"
                                   , "-L", "30"
                                   , "-H", "65"
                                   , "-l", "#7e57c2"
                                   , "-n", "#7e57c2"
                                   , "-h", "#fb4934"] 50

				 -- , Run ComX "iwgetid" ["-r"] "N/A" "wifi" 30
					, Run CommandReader "sh ~/.config/bspwm/panel/wifi.sh -a" "wifi"
					, Run CommandReader "amixer get Master | awk -F'[]%[]' '/%/ { print $2 }' | head -n 1 > /tmp/volume ; tail -f -q -n +0 /tmp/volume 2> /dev/null" "vol"
          , Run CommandReader "~/.config/bspwm/panel/workspaces_bspwm" "workspaces"
          , Run Com ".config/bspwm/panel/trayer-padding.sh" [] "trayer" 20
                    ]
       , sepChar = "$"
       , alignSep = "}{"
       , template = "<fc=#7e57c2><fn=1>$trayer$<fc=#222638></fc> $date$ <fc=#222638></fc> <fc=#c50ed2><fn=1></fn></fc><fn=2> $wifi$</fn> $dynnetwork$ <fc=#222638></fc> <fc=#c50ed2> </fc><fn=2>$vol$</fn><fn=4>%</fn> <fc=#222638></fc> <fc=#c50ed2><fn=1> </fn></fc><fn=2>$thermal0$</fn> <fc=#222638></fc> $memory$ <fc=#222638></fc> $cpu$ </fn></fc> }{ <fn=1>$workspaces$ </fn>"
       }
