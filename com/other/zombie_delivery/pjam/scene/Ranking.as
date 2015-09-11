class pjam.scene.Ranking
{
    var root, scene, pdata, _alpha, onEnterFrame, rankData, _x, moveID, moveNum, obj;
    function Ranking(root, pdata)
    {
        this.root = root;
        scene = root.rankMC;
        this.pdata = pdata;
        scene.dummyBtn.useHandCursor = false;
        scene.mc.setMask(scene.maskMC);
        scene.upBtn1.useHandCursor = false;
        scene.upBtn2.useHandCursor = false;
        scene.downBtn1.useHandCursor = false;
        scene.downBtn2.useHandCursor = false;
    } // End of the function
    function start()
    {
        root.loadMC._visible = true;
        root.loadMC.gotoAndStop(1);
        root.loadMC.maruMC.gotoAndPlay(1);
        var _loc3 = {mode: 4, rank: RANK_MAX, data: ""};
        var sc = this;
        var num = 0;
        var _loc2 = new net.LinkCGI();
        _loc2.suc = function (data)
        {
            sc.rankData = data;
            sc.pdata.setRegistTime();
            sc.root.loadMC.gotoAndStop("end");
            num = setInterval(function ()
            {
                clearInterval(num);
                sc.dispStart();
            }, 1000);
        };
        _loc2.mis = function ()
        {
            sc.dispErr();
        };
        _loc2.sendAndLoad(pjam.CmnProject.CGI_URL, "POST", _loc3);
    } // End of the function
    function dispStart()
    {
        root.loadMC._visible = false;
        var sc = this;
        scene._visible = true;
        scene._alpha = 0;
        scene.onEnterFrame = function ()
        {
            if ((_alpha = _alpha + 25) < 100)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            sc.dispMyRank();
            sc.selectRank();
        };
    } // End of the function
    function selectRank()
    {
        var sc = this;
        scene.mc.backBtn.onPress = function ()
        {
            sc.dispEnd();
        };
        var _loc2 = 0;
        var _loc3 = 0;
        while (_loc2 < RANK_MAX)
        {
            scene.mc["rankBtn" + _loc3].onPress = this.pushRankBtn(_loc2);
            _loc2 = _loc2 + RANK_BLOCK;
            _loc3++;
        } // end while
    } // End of the function
    function dispMyRank()
    {
        for (var _loc2 = 0; _loc2 < RANK_MAX; ++_loc2)
        {
            if (rankData["data" + _loc2] == undefined)
            {
                scene.mc.rankTxt.text = "-";
                break;
            } // end if
            var _loc3 = rankData["data" + _loc2].split(",");
            if (pdata.getID() != _loc3[0])
            {
                continue;
            } // end if
            scene.mc.rankTxt.text = _loc2 + 1;
            break;
        } // end of for
    } // End of the function
    function pushRankBtn(num)
    {
        var sc = this;
        return (function ()
        {
            sc.moveNum = num;
            delete sc.scene.mc.backBtn.onPress;
            for (var _loc2 = 0; _loc2 < sc.RANK_MAX; _loc2 = _loc2 + sc.RANK_BLOCK)
            {
                delete sc.scene.mc["btn" + _loc2].onPress;
            } // end of for
            var xPos = -sc.scene.mc.movePointMC._x;
            sc.stageSpeed = sc.STAGE_FIRST_SPEED;
            sc.scene.mc.onEnterFrame = function ()
            {
                sc.stageSpeed = sc.stageSpeed * sc.STAGE_MINUS_SPEED;
                _x = _x - sc.stageSpeed;
                if (sc.scene.mc._x > xPos)
                {
                    return;
                } // end if
                sc.scene.mc._x = xPos;
                delete this.onEnterFrame;
                sc.dispRank();
            };
        });
    } // End of the function
    function dispRank()
    {
        var sc = this;
        scene.upBtn1.onRollOver = function ()
        {
            sc.moveRank(1, -1);
        };
        scene.upBtn2.onRollOver = function ()
        {
            sc.moveRank(2, -1);
        };
        scene.downBtn1.onRollOver = function ()
        {
            sc.moveRank(1, 1);
        };
        scene.downBtn2.onRollOver = function ()
        {
            sc.moveRank(2, 1);
        };
        scene.upBtn1.onRollOut = function ()
        {
            clearInterval(sc.moveID);
            sc.scene.mc.selectUpMC.gotoAndStop(1);
            sc.scene.mc.selectDownMC.gotoAndStop(1);
        };
        scene.upBtn2.onRollOut = scene.upBtn1.onRollOut;
        scene.downBtn1.onRollOut = scene.upBtn1.onRollOut;
        scene.downBtn2.onRollOut = scene.upBtn1.onRollOut;
        scene.mc.changeBtn.onPress = function ()
        {
            delete sc.scene.upBtn1.onRollOver;
            delete sc.scene.upBtn2.onRollOver;
            delete sc.scene.downBtn1.onRollOver;
            delete sc.scene.downBtn2.onRollOver;
            delete sc.scene.upBtn1.onRollOut;
            delete sc.scene.upBtn2.onRollOut;
            delete sc.scene.downBtn1.onRollOut;
            delete sc.scene.downBtn2.onRollOut;
            sc.stageSpeed = sc.STAGE_FIRST_SPEED;
            sc.scene.mc.onEnterFrame = function ()
            {
                sc.stageSpeed = sc.stageSpeed * sc.STAGE_MINUS_SPEED;
                _x = _x + sc.stageSpeed;
                if (sc.scene.mc._x < 0)
                {
                    return;
                } // end if
                sc.scene.mc._x = 0;
                delete this.onEnterFrame;
                sc.selectRank();
            };
        };
        this.dispData();
    } // End of the function
    function moveRank(speed, vec)
    {
        if (vec == 1)
        {
            scene.mc.selectDownMC.nextFrame();
        }
        else
        {
            scene.mc.selectUpMC.nextFrame();
        } // end else if
        clearInterval(moveID);
        var _loc2 = new Object();
        _loc2.interval = function (sc)
        {
            sc.moveNum = sc.moveNum + vec;
            sc.dispData();
        };
        moveID = setInterval(_loc2.interval, this["SPEED" + speed], this);
    } // End of the function
    function dispData()
    {
        if (moveNum < 0)
        {
            ++moveNum;
            return;
        } // end if
        if (moveNum > RANK_MAX - DISP_RANK)
        {
            --moveNum;
            return;
        } // end if
        var sc = this;
        var _loc4 = moveNum;
        var _loc5 = 0;
        while (_loc4 < moveNum + DISP_RANK)
        {
            var _loc2 = scene.mc["dataMC" + _loc5];
            _loc2.rankTxt.text = _loc4 + 1;
            if (rankData["data" + _loc4] != undefined)
            {
                var _loc3 = pjam.Charactor.getCharData(root, rankData["data" + _loc4]);
                var _loc6 = _loc2.charMC.mc.attachMovie(_loc3.id, _loc3.id, 1);
                _loc2.charMC.mc._visible = true;
                _loc6.mc.gotoAndStop(1);
                _loc2.moneyTxt.text = _loc3.money;
                _loc2.nameTxt.text = _loc3.name;
                _loc2.charNameTxt.text = _loc3.charName;
                _loc2.nameTxt.textColor = _loc3.url != "" ? (URL_COLOR) : (NON_COLOR);
                _loc2.backBtn.obj = _loc3;
                _loc2.backBtn.onPress = function ()
                {
                    clearInterval(sc.moveID);
                    var _loc2 = new pjam.head.Status(sc.root, null);
                    _loc2.start(obj, pjam.head.Status.RK_DISP);
                };
            }
            else
            {
                _loc2.charMC.mc.removeMovieClip();
                _loc2.charMC.mc._visible = false;
                _loc2.moneyTxt.text = "-";
                _loc2.nameTxt.text = "";
                _loc2.charNameTxt.text = "";
            } // end else if
            _loc4++;
            _loc5++;
        } // end while
    } // End of the function
    function dispEnd()
    {
        clearInterval(moveID);
        var sc = this;
        scene.onEnterFrame = function ()
        {
            _alpha = _alpha - 25;
            if (_alpha > 0)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            sc.scene._visible = false;
            sc.end();
        };
    } // End of the function
    function dispErr()
    {
        var sc = this;
        scene.mc.backBtn.onPress = function ()
        {
            sc.scene._visible = false;
        };
    } // End of the function
    var SPEED1 = 100;
    var SPEED2 = 50;
    var STAGE_MINUS_SPEED = 0.900000;
    var STAGE_FIRST_SPEED = 20;
    var RANK_MAX = 500;
    var DISP_RANK = 5;
    var RANK_BLOCK = 50;
    var URL_COLOR = 10044416;
    var NON_COLOR = 0;
} // End of Class
