package herovsdragon.game.loader
{
    import __AS3__.vec.*;
    import com.dango_itimi.net.core.*;
    import com.dango_itimi.net.ctrl.*;
    import flash.net.*;

    public class ViewLoader extends Object
    {
        private const LOAD_SWF_SET:Vector.<String>;
        private var mainFunction:Function;
        private var loadRunnerMap:LoadRunnerMap;

        public function ViewLoader()
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            this.LOAD_SWF_SET = this.Vector.<String>(["box2d_view.swf", "game_view.swf"]);
            this.loadRunnerMap = new LoadRunnerMap();
            for each (_loc_1 in this.LOAD_SWF_SET)
            {
                
                _loc_2 = new URLRequest(_loc_1);
                _loc_3 = new LoadRunner(new BinaryLoader(_loc_2));
                this.loadRunnerMap.add(_loc_3, _loc_1);
            }
            this.loadRunnerMap.initializeLoaded();
            this.mainFunction = this.load;
            return;
        }// end function

        public function run() : Boolean
        {
            this.mainFunction();
            return this.mainFunction == this.end;
        }// end function

        private function load() : void
        {
            if (this.loadRunnerMap.run())
            {
                this.mainFunction = this.end;
            }
            return;
        }// end function

        private function end() : void
        {
            return;
        }// end function

        public function getBox2DView()
        {
            return this.loadRunnerMap.getLoadDataFromId(0);
        }// end function

        public function getGameView()
        {
            return this.loadRunnerMap.getLoadDataFromId(1);
        }// end function

    }
}
