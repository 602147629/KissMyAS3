class pjam.scene.GameMenu
{
    var root, scene, pdata, display;
    function GameMenu(root, pdata)
    {
        this.root = root;
        scene = root.stageMC.gameMenuMC;
        this.pdata = pdata;
    } // End of the function
    function start()
    {
        var sc = this;
        scene.fightBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectFight();
        };
        scene.statusBtn.onPress = function ()
        {
            sc.selectStatus();
        };
        scene.itemBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectItem();
        };
        scene.shopBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectShop();
        };
        scene.helpBtn.onPress = function ()
        {
            sc.selectHelp();
        };
        scene.endBtn.onPress = function ()
        {
            sc.destroy();
            sc.selectEnd();
        };
        scene.fightBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "戦闘を開始します。");
        };
        scene.statusBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ステータスを表示します。");
        };
        scene.itemBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "所持しているアイテムを使用します。");
        };
        scene.shopBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "店に行きアイテムを売買します。");
        };
        scene.helpBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ヘルプを表示します。");
        };
        scene.endBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "ゲームを終了しシステムメニューへ戻ります。");
        };
        display = new pjam.scene.gmenu.MenuDisplay(root, pdata);
        display.start();
    } // End of the function
    function destroy()
    {
        display.destroy();
        delete scene.fightBtn.onPress;
        delete scene.statusBtn.onPress;
        delete scene.itemBtn.onPress;
        delete scene.shopBtn.onPress;
        delete scene.helpBtn.onPress;
        delete scene.endBtn.onPress;
    } // End of the function
} // End of Class
