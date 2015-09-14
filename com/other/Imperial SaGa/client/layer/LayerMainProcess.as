package layer
{

    public class LayerMainProcess extends LayerBase
    {
        public static const BACKGROUND:int = 0;
        public static const MAIN:int = 1;
        public static const FADE:int = 2;
        public static const LOADING:int = 3;
        public static const OPTION:int = 4;
        public static const TOPBAR:int = 5;
        public static const MAX:int = 6;

        public function LayerMainProcess()
        {
            super(MAX);
            return;
        }// end function

    }
}
