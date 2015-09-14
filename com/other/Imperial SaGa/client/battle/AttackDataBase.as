package battle
{

    public class AttackDataBase extends Object
    {
        protected var _attackType:int;
        private var _aDamage:Array;
        private var _useSp:int;

        public function AttackDataBase()
        {
            this._aDamage = [];
            this._useSp = 0;
            return;
        }// end function

        public function get attackType() : int
        {
            return this._attackType;
        }// end function

        public function get aDamage() : Array
        {
            return this._aDamage.concat();
        }// end function

        public function set aDamage(param1:Array) : void
        {
            this._aDamage = param1.concat();
            return;
        }// end function

        public function get useSp() : int
        {
            return this._useSp;
        }// end function

        public function set useSp(param1:int) : void
        {
            this._useSp = param1;
            return;
        }// end function

    }
}
