Config {
       font = "xft:Dejavu Sans:size=10"
       , additionalFonts = [ "xft:Font Awesome 5 Pro:size=10","xft:Technology:size=12:Regular:antialias=true","xft:Dejavu Sans:size=13","xft:Robot Crush:size=12" ]
       , allDesktops = True
    -- , textOffset = 23
       , bgColor = "#0d0d0d"
       , fgColor = "#5beedc"
    -- , position = Static { xpos = 0 , ypos = 0, width = 1367, height = 22 }
       , position = TopSize L 100 10
    -- , border = FullBM 0
    -- , borderColor =  "#fff"
    -- , borderWidth = 0
       , commands = [ Run Cpu [ "--template", "<fc=#a2a1a1><fn=1></fn></fc><fn=2> <total></fn><fn=4>%</fn>"
                              , "--Low","3"
                              , "--High","80"
                              , "--low","#5beedc"
                              , "--normal","#5beedc"
                              , "--high","#fb4934"] 50

                    , Run Memory ["-t","<fc=#a2a1a1><fn=1></fn></fc><fn=2> <usedratio></fn><fn=4>%</fn>"
                                 ,"-H","80"
                                 ,"-L","10"
                                 ,"-l","#5beedc"
                                 ,"-n","#5beedc"
                                 ,"-h","#fb4934"] 50

                    , Run Date "<fc=#a2a1a1><fn=1></fn></fc><fn=2> %I:%M</fn>" "date" 300
                    , Run DynNetwork ["-t","<fc=#a2a1a1><fn=1></fn></fc><fn=2> <rx> </fn><fc=#a2a1a1><fn=1></fn></fc><fn=2> <tx></fn>"
                                     ,"-H","200"
                                     ,"-L","10"
                                     ,"-h","#5beedc"
                                     ,"-l","#5beedc"
                                     ,"-n","#5beedc"] 50
                   

                    , Run ThermalZone 0 ["-t","<fn=2><temp></fn><fn=4>°</fn>"
                                   , "-L", "30"
                                   , "-H", "65"
                                   , "-l", "#5beedc"
                                   , "-n", "#5beedc"
                                   , "-h", "#aa4450"] 50

         -- , Run CommandReader "sh .xmonad/bar.sh -a" "cpubar"
				 -- , Run CommandReader "sh .xmonad/bar.sh -l" "netbar"
				 -- , Run ComX "iwgetid" ["-r"] "N/A" "wifi" 30
					, Run CommandReader "sh .xmonad/wifi.sh -a" "wifi"
					, Run CommandReader "amixer get Master | awk -F'[]%[]' '/%/ { print $2 }' | head -n 1 > /tmp/volume ; tail -f -q -n +0 /tmp/volume 2> /dev/null" "vol"
          , Run Com ".xmonad/trayer-padding.sh" [] "trayer" 20

                    , Run UnsafeStdinReader
                    ]
       , sepChar = "$"
       , alignSep = "}{"
       , template = "<fc=#5beedc><fn=1>$trayer$<fc=#1d1d1d></fc> $date$ <fc=#1d1d1d></fc> <fc=#a2a1a1><fn=1></fn></fc><fn=2> $wifi$</fn> $dynnetwork$ <fc=#1d1d1d></fc> <fc=#a2a1a1> </fc><fn=2>$vol$</fn><fn=4>%</fn> <fc=#1d1d1d></fc> <fc=#a2a1a1><fn=1> </fn></fc><fn=2>$thermal0$</fn> <fc=#1d1d1d></fc> $memory$ <fc=#1d1d1d></fc> $cpu$ </fn></fc> }{ <fn=2>$UnsafeStdinReader$ </fn>"
       }
