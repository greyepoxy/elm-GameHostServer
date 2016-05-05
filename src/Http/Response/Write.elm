module Http.Response.Write (..) where

import Native.Http.Response.Write
import VirtualDom

writeNode : VirtualDom.Node -> String
writeNode node =
  Native.Http.Response.Write.toHtml node
