class pjam.scene.gmenu.DropMoney
{
    var root, scene, pdata, charMC, idNum, mc, _currentframe, _totalframes, removeMovieClip;
    function DropMoney(root, pdata, dPoint, charMC, idNum)
    {
        this.root = root;
        scene = root.stageMC.gameMenuMC.displayMC;
        this.pdata = pdata;
        this.charMC = charMC;
        this.idNum = idNum;
        this.dPoint = dPoint;
        var _loc4 = scene.getNextHighestDepth();
        mc = scene.attachMovie(MC_NAME, MC_NAME + _loc4, _loc4);
        var _loc2 = function (n)
        {
            return (Math.floor(Math.random() * n));
        };
        var _loc3 = _loc2(1000);
        if (_loc3 == 0)
        {
            money = _loc2(10000);
        }
        else if (_loc3 < 10)
        {
            money = _loc2(1000);
        }
        else if (_loc3 < 100)
        {
            money = _loc2(100);
        }
        else
        {
            money = _loc2(10);
        } // end else if
    } // End of the function
    function start()
    {
        var sc = this;
        mc._x = scene.areaMC._width;
        mc._alpha = 0;
        mc.onEnterFrame = function ()
        {
            sc.drop();
        };
    } // End of the function
    function destroy()
    {
        mc.removeMovieClip();
    } // End of the function
    function drop()
    {
        if (mc._alpha < 100)
        {
            mc._alpha = mc._alpha + 20;
        } // end if
        mc._x = mc._x + -pjam.scene.gmenu.MenuDisplay.SCROLL;
        if ((mc._y = mc._y + (dSpeed = dSpeed * pSpeed)) < dPoint)
        {
            return;
        } // end if
        mc._y = dPoint;
        var sc = this;
        mc.onEnterFrame = function ()
        {
            sc.scroll();
        };
    } // End of the function
    function scroll()
    {
        mc._x = mc._x + -pjam.scene.gmenu.MenuDisplay.SCROLL;
        if (scene.charMC._x < mc._x)
        {
            return;
        } // end if
        pdata.setMoney(money);
        scene.moneyTxt.text = Number(scene.moneyTxt.text) + money;
        var _loc2 = new Sound();
        _loc2.attachSound("getMoneySound");
        _loc2.start();
        var _loc3 = new pjam.fight.TextEffect(root, scene);
        _loc3.start(money.toString() + " GOLD GET", scene.getMoneyMC, 16764023, pjam.fight.TextEffect.MONEY_MODE);
        var sc = this;
        mc.play();
        mc.onEnterFrame = function ()
        {
            if (_currentframe < _totalframes)
            {
                return;
            } // end if
            this.removeMovieClip();
            sc.end(sc.idNum);
        };
    } // End of the function
    var MC_NAME = "dropMoneyMC";
    var dPoint = 0;
    var dSpeed = 1;
    var pSpeed = 1.200000;
    var money = 0;
} // End of Class
