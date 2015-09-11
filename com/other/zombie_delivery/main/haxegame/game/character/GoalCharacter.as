package haxegame.game.character
{
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;

    public class GoalCharacter extends Object
    {
        public var successView:IMovieClipUtil;
        public var position:MovieClip;
        public var neutralView:IMovieClipUtil;
        public var missView:IMovieClipUtil;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;
        public var gameOutView:IMovieClipUtil;
        public var actionView:IMovieClipUtil;

        public function GoalCharacter(param1:IDisplayObjectContainer = undefined, param2:MovieClip = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            position = param2;
            layer = param1;
            createView();
            setMovieClip(neutralView);
            setMovieClip(successView);
            setMovieClip(missView);
            setMovieClip(gameOutView);
            initialize();
            return;
        }// end function

        public function wait() : void
        {
            neutralView.loopFrame();
            return;
        }// end function

        public function setSuccess() : void
        {
            initializeAction(successView);
            return;
        }// end function

        public function setMovieClip(param1:IMovieClipUtil) : void
        {
            param1.mc.stop();
            param1.setPosition(position);
            return;
        }// end function

        public function setMiss() : void
        {
            initializeAction(missView);
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            return;
        }// end function

        public function playGameOut() : void
        {
            if (!gameOutView.isLastFrame())
            {
                gameOutView.nextFrame();
            }
            else
            {
                mainFunction = finishGameOut;
            }
            return;
        }// end function

        public function playAction() : void
        {
            if (!actionView.isLastFrame())
            {
                actionView.nextFrame();
            }
            else
            {
                layer.removeChild(actionView.mc);
                initialize();
            }
            return;
        }// end function

        public function isFinishedToPlayGameOut() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finishGameOut);
        }// end function

        public function initializeGameOut() : void
        {
            if (layer.contains(neutralView.mc))
            {
                layer.removeChild(neutralView.mc);
            }
            if (layer.contains(successView.mc))
            {
                layer.removeChild(successView.mc);
            }
            if (layer.contains(missView.mc))
            {
                layer.removeChild(missView.mc);
            }
            layer.addChild(gameOutView.mc);
            mainFunction = playGameOut;
            return;
        }// end function

        public function initializeAction(param1:IMovieClipUtil) : void
        {
            if (Reflect.compareMethods(mainFunction, playAction))
            {
                return;
            }
            layer.removeChild(neutralView.mc);
            actionView = param1;
            actionView.gotoFirstFrame();
            layer.addChild(actionView.mc);
            mainFunction = playAction;
            return;
        }// end function

        public function initialize() : void
        {
            neutralView.gotoFirstFrame();
            layer.addChild(neutralView.mc);
            mainFunction = wait;
            return;
        }// end function

        public function finishGameOut() : void
        {
            return;
        }// end function

        public function destroy() : void
        {
            if (layer.contains(neutralView.mc))
            {
                layer.removeChild(neutralView.mc);
            }
            if (layer.contains(successView.mc))
            {
                layer.removeChild(successView.mc);
            }
            if (layer.contains(missView.mc))
            {
                layer.removeChild(missView.mc);
            }
            if (layer.contains(gameOutView.mc))
            {
                layer.removeChild(gameOutView.mc);
            }
            return;
        }// end function

        public function createView() : void
        {
            return;
        }// end function

    }
}
