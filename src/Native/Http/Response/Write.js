var _greyepoxy$elm_gamehostserver$Native_Http_Response_Write = function() {

function factsToHtml(facts) {
  var resultStr = "";
  for (var fact in facts) {
    resultStr += " " + fact + "=\"" + facts[fact] + "\"";
  }
  return resultStr
}

function toHtml(vNode) {
  switch (vNode.type)
  {
    case 'thunk':
      if (!vNode.node)
      {
        vNode.node = vNode.thunk();
      }
      return toHtml(vNode.node);

    case 'tagger':
      throw Error("Currently cannot toHtmlString mapped nodes.")

    case 'text':
      return vNode.text;

    case 'node':
      var result = "<" + vNode.tag + factsToHtml(vNode.facts) + ">"
      
      var children = vNode.children;
      for (var i = 0; i < children.length; i++)
      {
        result += toHtml(children[i]);
      }
      
      return result + "</"+ vNode.tag +">";

    case 'custom':
      throw Error("Currently cannot toHtmlString custom nodes.")
  }
}

return {
  toHtml: toHtml
};

}();
