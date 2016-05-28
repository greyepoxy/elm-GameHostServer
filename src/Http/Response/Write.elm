module Http.Response.Write exposing (..)

import Native.Http.Response.Write
import VirtualDom

writeNode : VirtualDom.Node a -> String
writeNode node =
  Native.Http.Response.Write.toHtml node
