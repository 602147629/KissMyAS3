package haxegame.tutorial
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.event.*;
    import flash.*;
    import flash.display.*;
    import haxegame.se.*;
    import haxegame.tutorial._Tutorial.*;

    public class Tutorial extends Object
    {
        public var scene2:Scene2;
        public var scene1:Scene1;
        public var mouseEventChecker:MouseEventChecker;
        public var mainFunction:Function;
        public var layer:IDisplayObjectContainer;

        public function Tutorial(param1:IDisplayObjectContainer = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            mouseEventChecker = CommonClassSet.createMouseEventChecker(param1);
            layer = param1;
            scene1 = new Scene1(param1, mouseEventChecker);
            scene2 = new Scene2(param1, mouseEventChecker);
            return;
        }// end function

        public function run() : void
        {
            mainFunction();
            mouseEventChecker.reset();
            return;
        }// end function

        public function playScene2() : void
        {
            scene2.run();
            if (scene2.isFinished())
            {
                destroyScene2();
            }
            return;
        }// end function

        public function playScene1() : void
        {
            scene1.run();
            if (scene1.isFinished())
            {
                destroyScene1();
            }
            return;
        }// end function

        public function isFinished() : Boolean
        {
            return Reflect.compareMethods(mainFunction, finish);
        }// end function

        public function initializeScene2() : void
        {
            SoundMixer.playSelect();
            scene2.show();
            mainFunction = playScene2;
            return;
        }// end function

        public function initialize() : void
        {
            scene1.show();
            mainFunction = playScene1;
            return;
        }// end function

        public function finish() : void
        {
            return;
        }// end function

        public function destroyScene2() : void
        {
            scene2.hide();
            mainFunction = finish;
            return;
        }// end function

        public function destroyScene1() : void
        {
            scene1.hide();
            initializeScene2();
            return;
        }// end function

    }
}
