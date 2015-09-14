package player
{

    public class GrowthParameterData extends Object
    {
        private var _rarity:int;
        private var _life:int;
        private var _graphic:int;

        public function GrowthParameterData()
        {
            return;
        }// end function

        public function get rarity() : int
        {
            return this._rarity;
        }// end function

        public function get life() : int
        {
            return this._life;
        }// end function

        public function get graphic() : int
        {
            return this._graphic;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._rarity = int(param1.rarity);
            this._life = param1.life;
            this._graphic = param1.graphic;
            return;
        }// end function

    }
}
