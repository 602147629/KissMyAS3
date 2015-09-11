class comp.TextEffect.Line
{
    var lineMC, fontData, color, type, soundFlg, width, align, index, headFlg, stopFlg, scope, lineEnd;
    function Line()
    {
    } // End of the function
    function start(str, lineMC, fontData, color, type, soundFlg, width, align, index, headFlg, stopFlg)
    {
        this.lineMC = lineMC;
        this.fontData = fontData;
        this.color = color;
        this.type = type;
        this.soundFlg = soundFlg;
        this.width = width;
        this.align = align;
        this.index = index;
        this.headFlg = headFlg;
        this.stopFlg = stopFlg;
        this.disp(str);
    } // End of the function
    function disp(str)
    {
        str = this.changeStrExe(str);
        var _loc2 = new comp.TextEffect.Main();
        _loc2.scope = this;
        _loc2.textEnd = textEnd;
        var _loc3 = lineMC.createEmptyMovieClip("empMC" + mcNum, lineMC.getNextHighestDepth());
        _loc3._y = lineHeight;
        _loc2.disp(str, _loc3, fontData, color, type, soundFlg, width, align);
    } // End of the function
    function destroy()
    {
        for (var _loc2 = 0; _loc2 <= mcNum; ++_loc2)
        {
            lineMC["empMC" + _loc2].removeMovieClip();
        } // end of for
        lineHeight = 0;
        mcNum = 0;
        changeFlg = false;
    } // End of the function
    function textEnd(event)
    {
        this = scope;
        if (event.enter == true)
        {
            ++mcNum;
            this.disp(event.rest);
        }
        else if (event.rest != "")
        {
            ++mcNum;
            lineHeight = lineHeight + index;
            this.disp(event.rest);
        }
        else
        {
            this.lineEnd();
        } // end else if
    } // End of the function
    function changeStrExe(str)
    {
        if (changeFlg == true)
        {
            return (str);
        } // end if
        changeFlg = true;
        if (headFlg == true)
        {
            str = "　" + str;
        } // end if
        if (stopFlg == false)
        {
            return (str);
        } // end if
        var _loc4 = "";
        for (var _loc3 = str; true; _loc3 = _loc2[1])
        {
            var _loc2 = this.checkPoint(_loc3);
            _loc4 = _loc4 + _loc2[0];
            if (_loc2[1] == null)
            {
                break;
            } // end if
        } // end of for
        return (_loc4);
    } // End of the function
    function checkPoint(str)
    {
        var _loc4 = str.indexOf("。");
        if (_loc4 == -1)
        {
            return ([str, null]);
        } // end if
        if (_loc4 == str.length - 1)
        {
            return ([str, null]);
        } // end if
        var _loc2 = util.StringEx.cutStr(str, "。");
        _loc2[0] = _loc2[0] + "。\n";
        if (headFlg == true)
        {
            _loc2[0] = _loc2[0] + "　";
        } // end if
        return ([_loc2[0], _loc2[1]]);
    } // End of the function
    var lineHeight = 0;
    var mcNum = 0;
    var changeFlg = false;
} // End of Class
