package layer
{

    public class LayerTradingPost extends LayerBase
    {
        public static const MAIN:int = 0;
        public static const POPUP:int = 1;
        public static const INSIGNIA:int = 2;
        public static const STATUS:int = 3;
        public static const MAX:int = 4;

        public function LayerTradingPost()
        {
            super(MAX);
            return;
        }// end function

    }
}
