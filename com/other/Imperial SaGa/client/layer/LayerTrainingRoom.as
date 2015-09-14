package layer
{

    public class LayerTrainingRoom extends LayerBase
    {
        public static const MAIN:int = 0;
        public static const BULLET:int = 1;
        public static const EFFECT:int = 2;
        public static const HEADER:int = 3;
        public static const POPUP:int = 4;
        public static const MAX:int = 5;

        public function LayerTrainingRoom()
        {
            super(MAX);
            return;
        }// end function

    }
}
