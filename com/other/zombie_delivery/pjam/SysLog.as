class pjam.SysLog
{
    var _alpha, onEnterFrame;
    static var timerID;
    function SysLog()
    {
    } // End of the function
    static function disp(root, str)
    {
        delete root.loghideMC.onEnterFrame;
        root.loghideMC._alpha = 0;
        clearInterval(pjam.SysLog.timerID);
        pjam.SysLog.lineObj.destroy();
        pjam.SysLog.lineObj.lineEnd = function ()
        {
            var _loc2 = {interval: function ()
            {
                clearInterval(pjam.SysLog.timerID);
                root.loghideMC.onEnterFrame = function ()
                {
                    if ((_alpha = _alpha + 10) < 100)
                    {
                        return;
                    } // end if
                    delete this.onEnterFrame;
                    pjam.SysLog.lineObj.destroy();
                };
            }};
            timerID = setInterval(_loc2.interval, 4000);
        };
        pjam.SysLog.lineObj.start(str, root.syslogMC, pjam.SysLog.FONT_DATA, 3154192, comp.TextEffect.Main.TYPE1, false, 220, comp.TextEffect.TextAlign.LEFT, 14, false, false);
    } // End of the function
    static var lineObj = new comp.TextEffect.Line();
    static var FONT_DATA = [["markMC", 10, ""], ["hiraMC", 16, ""], ["kataMC", 16, ""], ["kanjMC", 10, ""]];
} // End of Class
