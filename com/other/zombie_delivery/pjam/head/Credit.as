class pjam.head.Credit
{
    var root, scene, url, getBounds, _y;
    function Credit(root)
    {
        this.root = root;
        scene = root.helpMC;
    } // End of the function
    function main()
    {
        var sc = this;
        for (var _loc2 = 0; _loc2 < CHAR_NUM; ++_loc2)
        {
            scene.stageMC["charBtn" + _loc2].url = this["CHAR_URL" + _loc2];
            scene.stageMC["charBtn" + _loc2].onPress = function ()
            {
                getURL(url, "_blank");
            };
            scene.stageMC["btn" + _loc2].url = this["BTN" + _loc2];
            scene.stageMC["btn" + _loc2].onPress = function ()
            {
                getURL(url, "_blank");
            };
        } // end of for
        var area = scene.areaMC.getBounds(root);
        scene.stageMC.onEnterFrame = function ()
        {
            var _loc2 = this.getBounds(sc.root);
            if (sc.root._ymouse > sc.scene.topMC._y && sc.root._ymouse < sc.scene.btmMC._y)
            {
                return;
            } // end if
            if (sc.root._ymouse < sc.scene.topMC._y)
            {
                _y = _y + sc.MOVE;
                if (_loc2.yMin > area.yMin)
                {
                    _y = _y - sc.MOVE;
                } // end if
            }
            else
            {
                _y = _y - sc.MOVE;
                if (_loc2.yMax < area.yMax)
                {
                    _y = _y + sc.MOVE;
                } // end if
            } // end else if
        };
    } // End of the function
    function destroy()
    {
        delete scene.stageMC.onEnterFrame;
    } // End of the function
    var MOVE = 5;
    var CHAR_NUM = 4;
    var CHAR_URL0 = "http://prmr.hp.infoseek.co.jp";
    var CHAR_URL1 = "http://www1.odn.ne.jp/haccan/";
    var CHAR_URL2 = "http://yougado.chips.jp/";
    var CHAR_URL3 = "http://www.dango-itimi.com";
    var BTN0 = "http://www.dango-itimi.com";
    var BTN1 = "http://www.dango-itimi.com/blog/";
    var BTN2 = "mailto:webmaster@dango-itimi.com";
} // End of Class
