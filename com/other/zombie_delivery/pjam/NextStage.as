class pjam.NextStage
{
    var root, stage, nowMC, _x, onEnterFrame, end, _alpha, removeMovieClip;
    function NextStage(root)
    {
        this.root = root;
    } // End of the function
    function start(id, vec)
    {
        stage = root.stageMC.moveMC;
        var _loc3 = root.stageMC.getNextHighestDepth();
        var nextMC = root.stageMC.attachMovie(id, id, _loc3);
        var path = vec == 1 ? (stage.leftMC) : (stage.rightMC);
        this.setPoint(nowMC, stage.centerMC);
        this.setPoint(nextMC, path);
        var first = stage._x;
        var point = stage.centerMC._x - path._x - first;
        var sc = this;
        var speed = FIRST_SPEED;
        stage.onEnterFrame = function ()
        {
            speed = speed * sc.MINUS_SPEED;
            _x = _x + vec * speed;
            sc.setPoint(sc.nowMC, sc.stage.centerMC);
            sc.setPoint(nextMC, path);
            if (vec == 1 && point > _x)
            {
                return;
            } // end if
            if (vec == -1 && point < _x)
            {
                return;
            } // end if
            _x = first;
            sc.setPoint(nextMC, sc.stage.centerMC);
            var _loc2 = new Sound();
            _loc2.attachSound("nextSound");
            _loc2.start();
            delete this.onEnterFrame;
            sc.alphaEffect(nextMC);
        };
    } // End of the function
    function alphaEffect(nextMC)
    {
        if (nowMC == undefined)
        {
            nowMC = nextMC;
            this.end();
            return;
        } // end if
        var sc = this;
        nowMC.onEnterFrame = function ()
        {
            _alpha = _alpha - 25;
            if (_alpha > 0)
            {
                return;
            } // end if
            this.removeMovieClip();
            sc.nowMC = nextMC;
            sc.end();
        };
    } // End of the function
    function setPoint(mc, path)
    {
        var _loc2 = {x: path._x, y: path._y};
        stage.localToGlobal(_loc2);
        mc._x = _loc2.x - root.stageMC._x;
    } // End of the function
    var FIRST_SPEED = 90;
    var MINUS_SPEED = 0.700000;
} // End of Class
