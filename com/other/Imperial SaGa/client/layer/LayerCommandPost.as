package layer
{

    public class LayerCommandPost extends LayerBase
    {
        public static const MAIN:int = 0;
        public static const EFFECT:int = 1;
        public static const POPUP:int = 2;
        public static const MAX:int = 3;

        public function LayerCommandPost()
        {
            super(MAX);
            return;
        }// end function

    }
}
