class comp.TextEffect.Main
{
    var path, effectList, textEnd, empMC;
    function Main()
    {
    } // End of the function
    function disp(str, path, fontData, color, type, soundFlg, strWidth, align)
    {
        this.soundFlg = soundFlg;
        this.fontData = fontData;
        restStr = "";
        this.path = path;
        var _loc3 = this.createTextList(str);
        effectList = this.createEffectList(str, path, _loc3, color, type, strWidth);
        if (effectList.length == 0)
        {
            this.textEnd({rest: restStr, enter: true});
            return;
        } // end if
        comp.TextEffect.TextAlign.setAlign(effectList, align);
        this.effectStart(effectList, path, type);
    } // End of the function
    function soundStart(mc)
    {
        if (soundFlg == false)
        {
            return;
        } // end if
        var _loc2 = "";
        if (mc._name.indexOf(fontData[comp.TextEffect.Main.MARK_CODE][0]) != -1)
        {
            _loc2 = fontData[comp.TextEffect.Main.MARK_CODE][2];
        }
        else if (mc._name.indexOf(fontData[comp.TextEffect.Main.HIRA_CODE][0]) != -1)
        {
            _loc2 = fontData[comp.TextEffect.Main.HIRA_CODE][2];
        }
        else if (mc._name.indexOf(fontData[comp.TextEffect.Main.KATA_CODE][0]) != -1)
        {
            _loc2 = fontData[comp.TextEffect.Main.KATA_CODE][2];
        }
        else
        {
            _loc2 = fontData[comp.TextEffect.Main.KANJ_CODE][2];
        } // end else if
        var _loc3 = new Sound(path);
        _loc3.attachSound(_loc2);
        _loc3.start(0, 0);
    } // End of the function
    function endExe(mc)
    {
        var _loc2 = util.StringEx.cutStr(mc._name, "MC")[1];
        if (_loc2 != effectList.length - 1)
        {
            return;
        } // end if
        this.textEnd({rest: restStr});
    } // End of the function
    function destroy()
    {
        for (var _loc2 = 0; _loc2 < effectList.length; ++_loc2)
        {
            effectList[_loc2].mc.removeMovieClip();
        } // end of for
        delete this.effectList;
        delete empMC.onEnterFrame;
        empMC.removeMovieClip();
    } // End of the function
    function createTextList(str)
    {
        var _loc4 = new Array();
        str = this.changeEnterStr(str);
        for (var _loc2 = 0; _loc2 < str.length; ++_loc2)
        {
            _loc4.push(this.getFontTypeList(str.charAt(_loc2)));
        } // end of for
        return (_loc4);
    } // End of the function
    function changeEnterStr(str)
    {
        var _loc1 = util.StringEx.cutStr(str, "\n");
        if (_loc1[1] == null)
        {
            return (str);
        } // end if
        return (_loc1[0] + comp.TextEffect.Main.ENTER_CHAR + _loc1[1]);
    } // End of the function
    function getFontTypeList(char)
    {
        var _loc2 = char.charCodeAt(0);
        var _loc6 = this.checkFontType(_loc2, comp.TextEffect.Main.MARK_CODE);
        var _loc3 = this.checkFontType(_loc2, comp.TextEffect.Main.HIRA_CODE);
        var _loc4 = this.checkFontType(_loc2, comp.TextEffect.Main.KATA_CODE);
        if (_loc6 != -1)
        {
            return ([fontData[comp.TextEffect.Main.MARK_CODE][0], char]);
        }
        else if (_loc3 != -1)
        {
            return ([fontData[comp.TextEffect.Main.HIRA_CODE][0], comp.TextEffect.Main.kanaStr.charAt(_loc3)]);
        }
        else if (_loc4 != -1)
        {
            return ([fontData[comp.TextEffect.Main.KATA_CODE][0], comp.TextEffect.Main.kanaStr.charAt(_loc4)]);
        }
        else
        {
            return ([fontData[comp.TextEffect.Main.KANJ_CODE][0], char]);
        } // end else if
    } // End of the function
    function checkFontType(num, type)
    {
        var _loc1 = comp.TextEffect.Main.codeList[type][0];
        var _loc2 = 0;
        while (_loc1 <= comp.TextEffect.Main.codeList[type][1])
        {
            if (_loc1 == num)
            {
                return (_loc2);
            } // end if
            _loc1++;
            _loc2++;
        } // end while
        return (-1);
    } // End of the function
    function createEffectList(str, path, list, color, type, strWidth)
    {
        var _loc9 = new Array();
        var _loc6 = 0;
        for (var _loc3 = 0; _loc3 < list.length; ++_loc3)
        {
            var _loc2 = path.attachMovie(list[_loc3][0], list[_loc3][0] + _loc3, _loc3);
            _loc2[comp.TextEffect.Main.TEXT_NAME].text = list[_loc3][1];
            _loc2[comp.TextEffect.Main.TEXT_NAME].textColor = color;
            _loc2[comp.TextEffect.Main.TEXT_NAME].autoSize = true;
            var _loc5 = new TextFormat();
            _loc5.size = this.getFontSize(list[_loc3][0]);
            _loc2[comp.TextEffect.Main.TEXT_NAME].setTextFormat(_loc5);
            _loc2._x = _loc6;
            if (strWidth != 0 && strWidth < _loc6 + _loc2._width - 4)
            {
                _loc2.removeMovieClip();
                restStr = str.substring(_loc3);
                break;
            } // end if
            if (_loc2[comp.TextEffect.Main.TEXT_NAME].text == comp.TextEffect.Main.ENTER_CHAR)
            {
                _loc2.removeMovieClip();
                restStr = str.substring(_loc3 + 1);
                break;
            } // end if
            _loc9.push(this.createEffectObj(_loc2, type));
            _loc6 = _loc6 + Math.ceil(_loc2._width - 4);
        } // end of for
        _loc9 = this.checkRandomType(type, _loc9);
        return (_loc9);
    } // End of the function
    function getFontSize(name)
    {
        if (name == fontData[comp.TextEffect.Main.MARK_CODE][0])
        {
            return (fontData[comp.TextEffect.Main.MARK_CODE][1]);
        }
        else if (name == fontData[comp.TextEffect.Main.HIRA_CODE][0])
        {
            return (fontData[comp.TextEffect.Main.HIRA_CODE][1]);
        }
        else if (name == fontData[comp.TextEffect.Main.KATA_CODE][0])
        {
            return (fontData[comp.TextEffect.Main.KATA_CODE][1]);
        }
        else
        {
            return (fontData[comp.TextEffect.Main.KANJ_CODE][1]);
        } // end else if
    } // End of the function
    function createEffectObj(mc, type)
    {
        if (type == comp.TextEffect.Main.TYPE0)
        {
            return (new comp.TextEffect.effect.Line(mc, this));
        }
        else if (type == comp.TextEffect.Main.TYPE1)
        {
            return (new comp.TextEffect.effect.Normal(mc, this));
        }
        else if (type == comp.TextEffect.Main.TYPE1_RAN)
        {
            return (new comp.TextEffect.effect.Normal(mc, this));
        }
        else if (type == comp.TextEffect.Main.TYPE2)
        {
            return (new comp.TextEffect.effect.Drop(mc, this));
        }
        else if (type == comp.TextEffect.Main.TYPE2_RAN)
        {
            return (new comp.TextEffect.effect.Drop(mc, this));
        }
        else if (type == comp.TextEffect.Main.TYPE3)
        {
            return (new comp.TextEffect.effect.Wide(mc, this));
        }
        else if (type == comp.TextEffect.Main.TYPE4)
        {
            return (new comp.TextEffect.effect.Pop(mc, this));
        } // end else if
    } // End of the function
    function checkRandomType(type, list)
    {
        if (type == comp.TextEffect.Main.TYPE1_RAN || type == comp.TextEffect.Main.TYPE2_RAN)
        {
            list = util.ArrayEx.randomList(list);
        } // end if
        return (list);
    } // End of the function
    function effectStart(list, path, type)
    {
        if (type == comp.TextEffect.Main.TYPE0)
        {
            this.soundStart(list[list.length - 1].mc);
            this.textEnd({rest: restStr});
            return;
        } // end if
        empMC = path.createEmptyMovieClip("empMC", path.getNextHighestDepth());
        for (var _loc2 = 0; _loc2 < list.length; ++_loc2)
        {
            list[_loc2].mc._visible = false;
        } // end of for
        var count = 0;
        var scope = this;
        empMC.onEnterFrame = function ()
        {
            list[count].effect();
            ++count;
            if (count >= list.length)
            {
                delete scope.empMC.onEnterFrame;
            } // end if
        };
    } // End of the function
    var soundFlg = false;
    var restStr = "";
    static var kanaStr = "#3Ee$4%5&6tTgGhH:*bBxXdDrRpPcCqQaA[zZwWsSui1,kfFUvVI2\"J^~K-=Ljn]/m\'7(8)9ol.;\\ 0  Yy";
    static var codeList = [[33, 126], [12353, 12435], [12449, 12531]];
    static var MARK_CODE = 0;
    static var HIRA_CODE = 1;
    static var KATA_CODE = 2;
    static var KANJ_CODE = 3;
    static var TEXT_NAME = "charTxt";
    static var ENTER_CHAR = "ж";
    static var TYPE0 = 0;
    static var TYPE1 = 1;
    static var TYPE1_RAN = 101;
    static var TYPE2 = 2;
    static var TYPE2_RAN = 102;
    static var TYPE3 = 3;
    static var TYPE4 = 4;
    var fontData = null;
} // End of Class
