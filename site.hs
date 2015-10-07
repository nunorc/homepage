
{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid (mappend)
import Hakyll

main :: IO ()
main = hakyll $ do
    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler
    match "static/*" $ do
        route $ setExtension "html"
        compile $ do
            let staticCtx = defaultContext
            pandocCompiler
                >>= loadAndApplyTemplate "tmpls/default.html" staticCtx
                >>= relativizeUrls
    match "index.html" $ do
        route idRoute
        compile copyFileCompiler
    match "tmpls/*" $ compile templateCompiler

