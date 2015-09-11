package haxegame.game
{
    import com.dango_itimi.physics.*;
    import flash.*;
    import haxegame.game.physics.box.*;
    import haxegame.game.physics.circle.*;

    public class AssetsParser extends Object
    {
        public var flashToPhysicsObjectParser:FlashToPhysicsObjectParser;
        public var coinShape:CoinShape;
        public var characterShape:CharacterShape;
        public var backgroundShape:BackgroundShape;

        public function AssetsParser() : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            flashToPhysicsObjectParser = new FlashToPhysicsObjectParser();
            addBox();
            addCircle();
            addPolygon();
            flashToPhysicsObjectParser.execute();
            return;
        }// end function

        public function addPolygon() : void
        {
            return;
        }// end function

        public function addCircle() : void
        {
            characterShape = new CharacterShape();
            flashToPhysicsObjectParser.registerInstance(PhysicsObjectType.CIRCLE, characterShape);
            coinShape = new CoinShape();
            flashToPhysicsObjectParser.registerInstance(PhysicsObjectType.CIRCLE, coinShape);
            return;
        }// end function

        public function addBox() : void
        {
            backgroundShape = new BackgroundShape();
            flashToPhysicsObjectParser.registerInstance(PhysicsObjectType.BOX, backgroundShape);
            return;
        }// end function

    }
}
