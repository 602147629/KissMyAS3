package enemy
{
    import flash.display.*;

    public class EnemyDisplayMetamorphoseBase extends EnemyDisplay
    {

        public function EnemyDisplayMetamorphoseBase(param1:DisplayObjectContainer, param2:int, param3:int)
        {
            super(param1, param2, param3);
            return;
        }// end function

        override public function setAnimMetamorphoseOut() : void
        {
            setAnimation(_LABEL_CHANGE_OUT);
            return;
        }// end function

        override public function setAnimMetamorphoseIn() : void
        {
            setAnimation(_LABEL_CHANGE_IN);
            return;
        }// end function

    }
}
