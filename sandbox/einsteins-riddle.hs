-- chat gpt created this

import Control.Monad (guard)

zip5 :: [a] -> [b] -> [c] -> [d] -> [e] -> [(a, b, c, d, e)]
zip5 (a:as) (b:bs) (c:cs) (d:ds) (e:es) = (a, b, c, d, e) : zip5 as bs cs ds es
zip5 _ _ _ _ _ = []

zip4 :: [a] -> [b] -> [c] -> [d] -> [(a, b, c, d)]
zip4 (a:as) (b:bs) (c:cs) (d:ds) = (a, b, c, d) : zip4 as bs cs ds
zip4 _ _ _ _ = []



data Color = Red | Green | White | Yellow | Blue deriving (Eq, Show)
data Nationality = Brit | Swede | Dane | Norwegian | German deriving (Eq, Show)
data Drink = Tea | Coffee | Milk | Beer | Water deriving (Eq, Show)
data Smoke = PallMall | Dunhill | Blend | BlueMaster | Prince deriving (Eq, Show)
data Pet = Dogs | Birds | Cats | Horse | Fish deriving (Eq, Show)

data House = House {
    color :: Color,
    nationality :: Nationality,
    drink :: Drink,
    smoke :: Smoke,
    pet :: Pet
} deriving (Eq, Show)

possibleHouses :: [(Color, Nationality, Drink, Smoke, Pet)]
possibleHouses = do
    colors <- permutations [Red, Green, White, Yellow, Blue]
    nationalities <- permutations [Brit, Swede, Dane, Norwegian, German]
    drinks <- permutations [Tea, Coffee, Milk, Beer, Water]
    smokes <- permutations [PallMall, Dunhill, Blend, BlueMaster, Prince]
    pets <- permutations [Dogs, Birds, Cats, Horse, Fish]
    guard $ and $ zipWith (\h p -> compatible h p) colors (zip4 nationalities drinks smokes pets)
    zip5 colors nationalities drinks smokes pets
    where
        permutations xs = do
            a <- xs
            b <- xs
            c <- xs
            d <- xs
            e <- xs
            guard $ a /= b && a /= c && a /= d && a /= e &&
                     b /= c && b /= d && b /= e &&
                     c /= d && c /= e &&
                     d /= e
            return [a, b, c, d, e]
        compatible :: Color -> (Nationality, Drink, Smoke, Pet) -> Bool
        compatible Red (Brit, _, _, _) = True
        compatible White (_, _, _, Cats) = True
        compatible Green (_, Coffee, _, _) = True
        compatible Yellow (Norwegian, _, _, _) = True
        compatible _ (_, Milk, _, _) = True
        compatible _ (Swede, _, _, Dogs) = True
        compatible _ (_, _, PallMall, Birds) = True
        compatible _ (Dane, _, Blend, _) = True
        compatible _ (_, _, _, Horse) = True
        compatible _ (German, _, Prince, _) = True
        compatible _ (Norwegian, _, _, _) = True
        compatible _ (_, Water, _, _) = True
        compatible _ _ = False

main :: IO ()
main = print possibleHouses
