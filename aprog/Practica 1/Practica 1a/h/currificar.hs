{-# LANGUAGE RankNTypes, FlexibleContexts, GADTs #-}
module Currificar where

cogerNoCurry :: forall a. (Int, [a]) -> [a]
cogerNoCurry = uncurry take
cogerCurry :: forall a. Int -> [a] -> [a]
cogerCurry = curry cogerNoCurry
