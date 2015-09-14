package loginBonus
{

    public class LoginBonusRemuneration extends Object
    {
        private var _type:int;
        private var _count:int;
        private var _id:int;
        private var _grade:int;

        public function LoginBonusRemuneration()
        {
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get grade() : int
        {
            return this._grade;
        }// end function

        public function setReceiveData(param1:Object) : void
        {
            this._type = param1.type;
            this._count = param1.count;
            this._id = param1.id;
            this._grade = param1.grade;
            return;
        }// end function

    }
}
