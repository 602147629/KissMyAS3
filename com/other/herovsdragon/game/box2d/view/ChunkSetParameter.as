package herovsdragon.game.box2d.view
{
    import com.dango_itimi.box2d.view.*;
    import flash.display.*;

    public class ChunkSetParameter extends ChunkSetDataMap
    {
        public static const ID_BOX_BACKGROUND:uint = 0;
        public static const ID_HERO:uint = 1;
        public static const ID_DRAGON:uint = 2;
        public static const ID_FIRE:uint = 3;
        private static const GROUP_FIRE:int = -1;

        public function ChunkSetParameter()
        {
            return;
        }// end function

        override public function initialize(param1:Sprite) : void
        {
            var _loc_2:* = param1 as Box2DView;
            this.initializeForBox(_loc_2);
            this.initializeForCircle(_loc_2);
            this.initializeForPolygon(_loc_2);
            return;
        }// end function

        private function initializeForBox(param1:Box2DView) : void
        {
            boxSets[ID_BOX_BACKGROUND] = new ChunkSetData(param1.boxBackground, false, false, 0, 0);
            boxSets[ID_HERO] = new ChunkSetData(param1.hero, true, false, 0, 0, true);
            boxSets[ID_DRAGON] = new ChunkSetData(param1.dragon, true, false, 0, 0, true, GROUP_FIRE);
            boxSets[ID_FIRE] = new ChunkSetData(param1.fireBreath, true, false, 0, 0, true, GROUP_FIRE);
            return;
        }// end function

        private function initializeForCircle(param1:Box2DView) : void
        {
            return;
        }// end function

        private function initializeForPolygon(param1:Box2DView) : void
        {
            return;
        }// end function

    }
}
