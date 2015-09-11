package haxegame.game.turn
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;

    public class NextTurn extends Object
    {
        public var view:NextTurnView;
        public var type:int;
        public var turnView:IMovieClipUtil;
        public var movieclip:IMovieClipUtil;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;

        public function NextTurn(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            layer = param1;
            view = new NextTurnView();
            view.mc.stop();
            movieclip = CommonClassSet.createMovieClipUtil(view);
            movieclip.mc.stop();
            type = 1;
            return;
        }// end function

        public function show(param1:int) : void
        {
            layer.addChild(view);
            movieclip.gotoFirstFrame();
            setType(param1);
            turnView = CommonClassSet.createMovieClipUtil(view.mc);
            if (!(type is Number))
            {
                throw "Class cast error";
            }
            turnView.gotoAndStop(type);
            mainFunction = play;
            return;
        }// end function

        public function setType(param1:int) : void
        {
            var _loc_2:* = NaN;
            if (param1 < 3)
            {
                type = 1;
            }
            else
            {
                _loc_2 = Math.random();
                if (_loc_2 < 0.075)
                {
                    type = 2;
                }
                else if (_loc_2 < 0.15)
                {
                    type = 3;
                }
                else
                {
                    type = 1;
                }
            }
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function play() : void
        {
            movieclip.nextFrame();
            if (movieclip.isLastFrame())
            {
                layer.removeChild(view);
                mainFunction = finish;
            }
            return;
        }// end function

        public function isFinished() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finish);
        }// end function

        public function finish() : void
        {
            return;
        }// end function

    }
}
