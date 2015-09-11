class pjam.scene.MainMenu
{
    var root, scene;
    function MainMenu(root)
    {
        this.root = root;
        scene = root.stageMC.mainMenuMC;
    } // End of the function
    function start(pdata)
    {
        var _loc2 = pdata.checkRegistTime();
        if (_loc2 != 0)
        {
            this.limit(pdata, _loc2);
        }
        else
        {
            this.normal();
        } // end else if
    } // End of the function
    function limit(pdata, rest)
    {
        var sc = this;
        scene.rankBtn._alpha = 70;
        scene.registBtn._alpha = 70;
        scene.rankBtn.onRollOver = function ()
        {
            sc.limitCmn(pdata, "秒後にランキング閲覧が可能です。");
        };
        scene.registBtn.onRollOver = function ()
        {
            sc.limitCmn(pdata, "秒後にゲームデータをネット登録することが可能です。");
        };
        this.cmn();
    } // End of the function
    function limitCmn(pdata, str)
    {
        var _loc2 = pdata.checkRegistTime();
        if (_loc2 == 0)
        {
            this.normal();
        }
        else
        {
            pjam.SysLog.disp(root, Math.floor(_loc2 / 1000) + str);
        } // end else if
    } // End of the function
    function normal()
    {
        var sc = this;
        scene.rankBtn._alpha = 100;
        scene.registBtn._alpha = 100;
        scene.rankBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectRank();
        };
        scene.registBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectRegist();
        };
        scene.rankBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ランキングを表示します。");
        };
        scene.registBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ゲームデータをネットに登録します。");
        };
        this.cmn();
    } // End of the function
    function cmn()
    {
        var sc = this;
        scene.gameBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectGame();
        };
        scene.deleteBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectDelete();
        };
        scene.gameBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "メインゲームを開始します。");
        };
        scene.deleteBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ゲームデータを削除します。");
        };
    } // End of the function
    function destroy()
    {
        delete scene.gameBtn.onPress;
        delete scene.rankBtn.onPress;
        delete scene.registBtn.onPress;
        delete scene.deleteBtn.onPress;
    } // End of the function
} // End of Class
