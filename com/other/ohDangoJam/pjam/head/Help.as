class pjam.head.Help
{
    var root, scene, sound, credit, num;
    function Help(root, sound)
    {
        this.root = root;
        scene = root.helpMC;
        this.sound = sound;
        credit = new pjam.head.Credit(root);
    } // End of the function
    function start(data, check)
    {
        var sc = this;
        scene._visible = true;
        root.closeBtn._visible = true;
        page = 1;
        scene.gotoAndStop(1);
        scene.topBtn.onPress = function ()
        {
            sc.page = 1;
            sc.scene.gotoAndStop(1);
            sc.setMenu();
        };
        scene.topBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "目次を表示します。");
        };
        scene.dummyBtn.useHandCursor = false;
        root.closeBtn.onPress = function ()
        {
            pjam.SysLog.disp(sc.root, " ");
            sc.root.closeBtn._visible = false;
            sc.scene._visible = false;
            sc.sound.playSound("mainSound");
            sc.credit.destroy();
        };
        scene.closeBtn2.onPress = root.closeBtn.onPress;
        this.setMenu();
        var _loc2 = new Sound();
        _loc2.attachSound("statusSound");
        _loc2.start();
        sound.playSound("songSound");
    } // End of the function
    function setMenu()
    {
        var sc = this;
        scene.backBtn._alpha = 50;
        scene.backBtn.enabled = false;
        this.setNextBtn();
        for (var _loc2 = 2; _loc2 <= PAGE_MAX; ++_loc2)
        {
            scene["btn" + _loc2].num = _loc2;
            scene["btn" + _loc2].onPress = function ()
            {
                sc.page = num;
                sc.scene.gotoAndStop(num);
                sc.setBackBtn();
                sc.setNextBtn();
                if (sc.page == sc.PAGE_MAX)
                {
                    sc.creditDisp();
                } // end if
            };
        } // end of for
    } // End of the function
    function setBackBtn()
    {
        var sc = this;
        scene.backBtn._alpha = 100;
        scene.backBtn.enabled = true;
        scene.backBtn.onPress = function ()
        {
            sc.backFunc();
        };
    } // End of the function
    function setNextBtn()
    {
        var sc = this;
        scene.nextBtn._alpha = 100;
        scene.nextBtn.enabled = true;
        scene.nextBtn.onPress = function ()
        {
            sc.nextFunc();
        };
    } // End of the function
    function nextFunc()
    {
        if (page == PAGE_MAX)
        {
            return;
        } // end if
        this.setBackBtn();
        scene.nextFrame();
        if (++page == PAGE_MAX)
        {
            this.creditDisp();
        } // end if
    } // End of the function
    function backFunc()
    {
        if (page == 1)
        {
            return;
        } // end if
        this.setNextBtn();
        scene.prevFrame();
        if (--page == 1)
        {
            this.setMenu();
        } // end if
    } // End of the function
    function creditDisp()
    {
        scene.nextBtn._alpha = 50;
        scene.nextBtn.enabled = false;
        delete scene.nextBtn.onPress;
        credit.main();
    } // End of the function
    var PAGE_MAX = 10;
    var page = 1;
} // End of Class
