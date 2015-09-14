package layer
{

    public class LayerMakeEquip extends LayerBase
    {
        public static const BACKGROUND:int = 0;
        public static const MAIN:int = 1;
        public static const MESSAGE_WINDOW:int = 2;
        public static const STONE:int = 3;
        public static const TITLE:int = 4;
        public static const POPUP:int = 5;
        public static const MAX:int = 6;

        public function LayerMakeEquip()
        {
            super(MAX);
            return;
        }// end function

    }
}
