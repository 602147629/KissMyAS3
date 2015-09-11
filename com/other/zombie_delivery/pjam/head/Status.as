class pjam.head.Status
{
    var root, scene, pdata, text, _visible;
    function Status(root, pdata)
    {
        this.root = root;
        scene = root.statusMC;
        this.pdata = pdata;
    } // End of the function
    function start(data, check)
    {
        var sc = this;
        scene._visible = true;
        root.closeBtn._visible = true;
        scene.charMC.attachMovie(data.id, data.id, 1);
        scene.moneyTxt.text = data.money;
        scene.lvTxt.text = data.lv;
        scene.exTxt.text = data.ex;
        scene.hpTxt.text = data.hp;
        scene.attackTxt.text = data.attack;
        scene.magicTxt.text = data.magic;
        scene.defenseTxt.text = data.defense;
        scene.speedTxt.text = data.speed;
        scene.luckTxt.text = data.luck;
        scene.itemTxt0.text = pjam.Charactor.getItemName(root, data.item0);
        scene.itemTxt1.text = pjam.Charactor.getItemName(root, data.item1);
        scene.itemTxt2.text = pjam.Charactor.getItemName(root, data.item2);
        scene.nameTxt.text = data.name;
        scene.charNameTxt.text = data.charName;
        scene.urlTxt.restrict = pjam.scene.CharCreate.OUT_STR;
        scene.urlTxt.text = data.url;
        var url = data.url;
        if (url == "")
        {
            scene.urlBtn._visible = false;
        }
        else
        {
            if (url.indexOf("http://") == -1)
            {
                url = "http://" + url;
            } // end if
            scene.urlBtn._visible = true;
            scene.urlBtn.onPress = function ()
            {
                getURL(url, "_blank");
            };
        } // end else if
        if (check == pjam.head.Status.MY_DISP)
        {
            pjam.SysLog.disp(root, "ステータス一覧表示\nWebサイトURLの編集が可能です。");
            scene.urlTxt.type = "input";
            scene.urlTxt.onChanged = function ()
            {
                sc.pdata.setUrl(text);
            };
        }
        else
        {
            scene.urlTxt.type = "dynamic";
        } // end else if
        scene.dummyBtn.useHandCursor = false;
        root.closeBtn.onPress = function ()
        {
            var _loc2 = sc.scene.dummyBtn._target;
            Selection.setFocus(_loc2);
            pjam.SysLog.disp(sc.root, " ");
            _visible = false;
            sc.scene._visible = false;
            delete sc.scene.urlTxt.onChanged;
        };
        var _loc3 = new Sound();
        _loc3.attachSound("statusSound");
        _loc3.start();
    } // End of the function
    static var MY_DISP = 1;
    static var RK_DISP = 2;
} // End of Class
