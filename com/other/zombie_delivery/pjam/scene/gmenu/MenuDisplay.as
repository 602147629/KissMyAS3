class pjam.scene.gmenu.MenuDisplay
{
    var root, scene, pdata, moneyList, bm, lineMC, charMC, sound, idNum;
    function MenuDisplay(root, pdata)
    {
        this.root = root;
        scene = root.stageMC.gameMenuMC.displayMC;
        BASE_LINE = scene.charMC._y;
        line = BASE_LINE;
        this.pdata = pdata;
        moneyList = new Object();
        scene.setMask(root.stageMC.gameMenuMC.maskMC);
        var _loc6 = scene.areaMC._width;
        var _loc4 = scene.areaMC._height;
        bm = new flash.display.BitmapData(_loc6, _loc4, true, 0);
        lineMC = scene.createEmptyMovieClip("lineMC", 0);
        lineMC.attachBitmap(bm, lineMC.getNextHighestDepth());
        var _loc2 = pjam.Charactor.getCharData(root, pdata.createRegistData());
        var _loc5 = scene.createEmptyMovieClip("empMC", 1);
        charMC = _loc5.attachMovie(_loc2.id, _loc2.id + 1, 1);
        charMC.gotoAndStop("runR");
        charMC._x = scene.charMC._x;
        charMC._y = scene.charMC._y;
        sound = new Sound(charMC);
        sound.setVolume(0);
        scene.moneyTxt.text = "0";
        this.firstLine();
        this.start();
    } // End of the function
    function start()
    {
        var sc = this;
        scene.onEnterFrame = function ()
        {
            sc.main();
        };
    } // End of the function
    function destroy()
    {
        delete this.sound;
        bm.dispose();
        charMC.removeMovieClip();
        lineMC.removeMovieClip();
        for (var _loc2 in moneyList)
        {
            moneyList[_loc2].destroy();
        } // end of for...in
    } // End of the function
    function main()
    {
        bm.scroll(-pjam.scene.gmenu.MenuDisplay.SCROLL, 0);
        this.setDrawPos();
        var _loc3 = scene.areaMC._width - pjam.scene.gmenu.MenuDisplay.SCROLL;
        var _loc4 = scene.areaMC._height;
        bm.fillRect(new flash.geom.Rectangle(_loc3, 0, pjam.scene.gmenu.MenuDisplay.SCROLL, _loc4), 0);
        bm.fillRect(new flash.geom.Rectangle(_loc3, line, pjam.scene.gmenu.MenuDisplay.SCROLL, _loc4 - line), baseColor);
        bm.fillRect(new flash.geom.Rectangle(_loc3, line, pjam.scene.gmenu.MenuDisplay.SCROLL, 1), lineColor);
        this.setCharPos();
        if (Math.floor(Math.random() * MONEY_RAN) != 1)
        {
            return;
        } // end if
        ++idNum;
        var _loc2 = new pjam.scene.gmenu.DropMoney(root, pdata, line, charMC, idNum);
        moneyList.idNum = _loc2;
        var sc = this;
        _loc2.end = function (n)
        {
            delete sc.moneyList[n];
        };
        _loc2.start();
    } // End of the function
    function firstLine()
    {
        var _loc2 = scene.areaMC._width;
        var _loc3 = scene.areaMC._height;
        bm.fillRect(new flash.geom.Rectangle(0, BASE_LINE, _loc2, _loc3 - BASE_LINE), baseColor);
        bm.fillRect(new flash.geom.Rectangle(0, BASE_LINE, _loc2, 1), lineColor);
    } // End of the function
    function setDrawPos()
    {
        if (scene._ymouse < line)
        {
            line = line - 1;
        } // end if
        if (scene._ymouse > line)
        {
            line = line + 1;
        } // end if
        if (line > BASE_LINE + BLUR_LINE)
        {
            line = BASE_LINE + BLUR_LINE;
        } // end if
        if (line < BASE_LINE - BLUR_LINE)
        {
            line = BASE_LINE - BLUR_LINE;
        } // end if
    } // End of the function
    function setCharPos()
    {
        for (var _loc2 = BASE_LINE - BLUR_LINE; _loc2 <= BASE_LINE + BLUR_LINE; ++_loc2)
        {
            if (lineColor.toString(16) != bm.getPixel32(charMC._x, _loc2).toString(16))
            {
                continue;
            } // end if
            charMC._y = _loc2;
            break;
        } // end of for
    } // End of the function
    static var SCROLL = 2;
    var BASE_LINE = 0;
    var BLUR_LINE = 10;
    var line = 0;
    var baseColor = 4294303683.000000;
    var lineColor = 4294293925.000000;
    var MONEY_RAN = 400;
} // End of Class
