class pjam.scene.Shop
{
    var root, pdata, scene, _currentframe, _totalframes, onEnterFrame, i, num, valueTxt;
    function Shop(root, pdata)
    {
        this.root = root;
        this.pdata = pdata;
        scene = root.stageMC.shopMC;
    } // End of the function
    function start()
    {
        var sc = this;
        scene.backBtn.onPress = function ()
        {
            sc.end();
        };
        scene.risuMC.play();
        scene.fukidasiMC.play();
        scene.fukidasiMC.onEnterFrame = function ()
        {
            if (_currentframe < _totalframes)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            sc.first();
        };
    } // End of the function
    function first()
    {
        scene.gotoAndStop("first");
        scene.msgMC.gotoAndStop("first");
        var sc = this;
        var _loc3 = false;
        var _loc2 = pdata.getItemList();
        var i = 0;
        while (i < 3)
        {
            if (_loc2[i] == -1)
            {
                scene["itemTxt" + i].text = "-";
                scene["priceTxt" + i].text = "-";
                scene["btn" + i].enabled = false;
            }
            else
            {
                scene["itemTxt" + i].text = pjam.Charactor.getItemName(root, _loc2[i]);
                scene["priceTxt" + i].text = pjam.Charactor.getItemPrice(root, _loc2[i]);
                scene["btn" + i].num = _loc2[i];
                scene["btn" + i].i = i;
                scene["btn" + i].onPress = function ()
                {
                    sc.check(num, i);
                };
                if (_loc2[i] == pdata.getCharNum() && _loc3 == false)
                {
                    _loc3 = true;
                    delete scene["btn" + i].onPress;
                    scene["btn" + i].onRollOver = function ()
                    {
                        pjam.SysLog.disp(sc.root, "装備しているアイテムは売れません。");
                    };
                } // end if
            } // end else if
            ++i;
        } // end while
        if (pdata.checkItemNum() == true)
        {
            scene.msgMC.gotoAndStop("no");
            return;
        } // end if
        this.dispPer();
    } // End of the function
    function dispPer()
    {
        var sc = this;
        scene.onEnterFrame = function ()
        {
            var _loc2 = Math.floor(Math.random() * 50);
            if (_loc2 == 0)
            {
                sc.val = 5;
            }
            else if (_loc2 < 4)
            {
                sc.val = 4;
            }
            else if (_loc2 < 10)
            {
                sc.val = 3;
            }
            else if (_loc2 < 18)
            {
                sc.val = 2;
            }
            else
            {
                sc.val = Math.floor(Math.random() * 20) / 10;
            } // end else if
            valueTxt.text = sc.val;
        };
    } // End of the function
    function check(num, i)
    {
        delete scene.onEnterFrame;
        scene.gotoAndStop("check");
        scene.msgMC.gotoAndStop("check");
        var sell = pjam.Charactor.getItemPrice(root, num);
        scene.itemTxt.text = pjam.Charactor.getItemName(root, num);
        scene.orgTxt.text = sell;
        scene.valueTxt.text = val;
        scene.sellTxt.text = sell * val;
        var sc = this;
        scene.noBtn.onPress = function ()
        {
            sc.first();
        };
        scene.yesBtn.onPress = function ()
        {
            sc.getDisp(num, i, sell * sc.val);
        };
    } // End of the function
    function getDisp(num, i, sell)
    {
        scene.gotoAndStop("get");
        scene.msgMC.gotoAndStop("get");
        scene.msgTxt.text = sell + "ゴールドゲット！";
        pdata.setMoney(sell);
        pdata.setItem(i, -1);
        var sc = this;
        scene.okBtn.onPress = function ()
        {
            sc.first();
        };
    } // End of the function
    var val = 0;
} // End of Class
