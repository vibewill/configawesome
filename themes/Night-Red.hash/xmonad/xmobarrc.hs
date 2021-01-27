Config {
       font = "xft:Dejavu Sans:size=10"
       , additionalFonts = [ "xft:Font Awesome 5 Pro:size=9","xft:Dejavu Sans:size=9","xft:Dejavu Sans:size=13","xft:Robot Crush:size=10","xft:Font Awesome 5 Pro:size=10" ]
       , allDesktops = True
    -- , textOffset = 23
       , bgColor = "#000000"
       , fgColor = "#aaaaaa"
    -- , position = Static { xpos = 0 , ypos = 0, width = 1367, height = 22 }
       , position = TopSize L 100 10
    -- , border = FullBM 0
    -- , borderColor =  "#fff"
    -- , borderWidth = 0
       , commands = [ Run Cpu [ "--template", "<fc=#ec0101><fn=1></fn></fc><fn=2> <total></fn><fn=4>%</fn>"
                              , "--Low","3"
                              , "--High","80"
                              , "--low","#aaaaaa"
                              , "--normal","#aaaaaa"
                              , "--high","#fb4934"] 50

                    , Run Memory ["-t","<fc=#ec0101><fn=1></fn></fc><fn=2> <usedratio></fn><fn=4>%</fn>"
                                 ,"-H","80"
                                 ,"-L","10"
                                 ,"-l","#aaaaaa"
                                 ,"-n","#aaaaaa"
                                 ,"-h","#fb4934"] 50

                    , Run Date "<fc=#ec0101><fn=1></fn></fc><fn=2> %I:%M</fn>" "date" 300
                    , Run DynNetwork ["-t","<fc=#ec0101><fn=1></fn></fc><fn=2> <rx> </fn><fc=#ec0101><fn=1></fn></fc><fn=2> <tx></fn>"
                                     ,"-H","200"
                                     ,"-L","10"
                                     ,"-h","#aaaaaa"
                                     ,"-l","#aaaaaa"
                                     ,"-n","#aaaaaa"] 50
                   

                    , Run ThermalZone 0 ["-t","<fn=2><temp></fn><fn=4>°</fn>"
                                   , "-L", "30"
                                   , "-H", "65"
                                   , "-l", "#aaaaaa"
                                   , "-n", "#aaaaaa"
                                   , "-h", "#aa4450"] 50

				 --	, Run CommandReader "sh .xmonad/bar.sh -a" "cpubar"
				 -- , Run CommandReader "sh .xmonad/bar.sh -l" "netbar"
				 -- , Run ComX "iwgetid" ["-r"] "N/A" "wifi" 30
					, Run CommandReader "sh .xmonad/wifi.sh -a" "wifi"
					, Run CommandReader "amixer get Master | awk -F'[]%[]' '/%/ { print $2 }' | head -n 1 > /tmp/volume ; tail -f -q -n +0 /tmp/volume 2> /dev/null" "vol"
          , Run Com ".xmonad/trayer-padding.sh" [] "trayer" 20

                    , Run UnsafeStdinReader
                    ]
       , sepChar = "$"
       , alignSep = "}{"
       , template = "<fc=#aaaaaa><fn=1>$trayer$<fc=#1a1919></fc> $date$ <fc=#1a1919></fc> <fc=#ec0101><fn=1></fn></fc><fn=2> $wifi$</fn> $dynnetwork$ <fc=#1a1919></fc> <fc=#ec0101> </fc><fn=2>$vol$</fn><fn=4>%</fn> <fc=#1a1919></fc> <fc=#ec0101><fn=1> </fn></fc><fn=2>$thermal0$</fn> <fc=#1a1919></fc> $memory$ <fc=#1a1919></fc> $cpu$ </fn></fc> }{ <fn=2>$UnsafeStdinReader$ </fn>"
       }
