class pjam.scene.Delete
{
    var root, pdata, scene;
    function Delete(root, pdata)
    {
        this.root = root;
        this.pdata = pdata;
        scene = root.stageMC.deleteMC;
    } // End of the function
    function start()
    {
        var sc = this;
        scene.backBtn.onPress = function ()
        {
            sc.deleteEnd();
        };
        scene.okBtn.onPress = function ()
        {
            sc.dataDelete();
        };
    } // End of the function
    function dataDelete()
    {
        root.loadMC._visible = true;
        root.loadMC.gotoAndStop(1);
        root.loadMC.maruMC.gotoAndPlay(1);
        if (pdata.getID() == -1)
        {
            this.dispEnd();
            return;
        } // end if
        var _loc3 = {mode: 3, rank: pjam.CmnProject.RANK_NUM, data: pdata.createRegistData()};
        var sc = this;
        var _loc5 = 0;
        var _loc2 = new net.LinkCGI();
        _loc2.suc = function (data)
        {
            sc.pdata.deleteID();
            sc.root.loadMC.gotoAndStop("msg");
            sc.root.loadMC.msgTxt.text = "see you again！";
            sc.root.loadMC.okBtn._visible = false;
        };
        _loc2.mis = function ()
        {
            sc.root.loadMC.gotoAndStop("err");
        };
        _loc2.sendAndLoad(pjam.CmnProject.CGI_URL, "POST", _loc3);
    } // End of the function
    function dispEnd()
    {
        pdata.deleteID();
        root.loadMC.gotoAndStop("msg");
        root.loadMC.msgTxt.text = "see you again！";
        root.loadMC.okBtn._visible = false;
    } // End of the function
} // End of Class
