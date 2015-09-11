class pjam.scene.Encount
{
    var root, scene, edata, pdata, fdata;
    function Encount(root, edata, pdata)
    {
        this.root = root;
        scene = root.stageMC.encountMC;
        this.edata = edata;
        this.pdata = pdata;
    } // End of the function
    function start()
    {
        var sc = this;
        scene.fightBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectFight(sc.fdata);
        };
        scene.changeBtn.onPress = function ()
        {
            sc.dispEnemy();
        };
        scene.menuBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectMenu();
        };
        scene.fightBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "この敵と戦います。");
        };
        scene.changeBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "戦う敵を変更します。");
        };
        scene.menuBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ゲームメニューへ戻ります。");
        };
        this.dispEnemy();
    } // End of the function
    function destroy()
    {
        pjam.SysLog.disp(root, " ");
        delete scene.fightBtn.onPress;
        delete scene.changeBtn.onPress;
        delete scene.menuBtn.onPress;
    } // End of the function
    function dispEnemy()
    {
        var _loc2;
        var _loc3 = Math.floor(Math.random() * CPU_PER);
        if (_loc3 == 0)
        {
            fdata = pjam.Charactor.getCpuData(root);
            _loc2 = "[CPU] ";
        }
        else if (_loc3 == 1)
        {
            fdata = pjam.Charactor.getNearCpuData(root, pdata);
            _loc2 = "[CPU] ";
        }
        else
        {
            fdata = edata.encountPlayer(pdata.getLv());
            _loc2 = "[PLAYER] ";
            if (fdata == null)
            {
                fdata = pjam.Charactor.getNearCpuData(root, pdata);
                _loc2 = "[CPU] ";
            } // end else if
        } // end else if
        scene.charMC.attachMovie(fdata.id, fdata.id, 1);
        scene.msgTxt.text = _loc2 + fdata.charName + "ガアラワレタ！";
        scene.nameTxt.text = fdata.name;
        scene.charNameTxt.text = fdata.charName;
        scene.lvTxt.text = fdata.lv;
        var url = fdata.url;
        if (url == "")
        {
            scene.urlBtn._visible = false;
            return;
        } // end if
        if (url.indexOf("http://") == -1)
        {
            url = "http://" + url;
        } // end if
        var _loc4 = this;
        scene.urlBtn._visible = true;
        scene.urlBtn.onPress = function ()
        {
            getURL(url, "_blank");
        };
    } // End of the function
    var CPU_PER = 3;
} // End of Class
