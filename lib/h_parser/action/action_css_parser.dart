import 'package:html/dom.dart';

import '../regexp_rule.dart';
import '../regexp_rule.dart';
import 'action_parser.dart';

class ActionCssParser extends ActionParser {
  ActionCssParser(Element element, String htmlString)
      : super(element, htmlString);

  @override
  List<Element> getElementsEachRule(String rule, bool needFilterText) {
    var resultList = List<Element>();

    List<String> u_split = rule.split(RegexpRule.DELIMITER);
    var filterReg = "";
    // 获取文本内容的类型
    if (u_split.length > 1 && needFilterText) {
      filterReg = u_split.removeLast();
    }

    var elements = mElement.querySelectorAll(u_split[0]);
    if (elements.isEmpty) {
      elements.addAll(getElementByStepSplitRule(u_split[0], ' ', mElement));
    }

    for (var i = 1; i < u_split.length; i++) {
      if (elements.isEmpty) {
        break;
      }
      var temp = List<Element>();
      for (var element in elements) {
        temp.addAll(element.querySelectorAll(u_split[i]));
      }
      elements = temp;
    }

    resultList.addAll(elements);

    //净化和过滤内容
    if (needFilterText) {
      var fele = List<Element>();
      for (var e in resultList) {
        fele.add(filterText(e, filterReg, replaceRegexp));
      }
      resultList = fele;
    }

    return resultList;
  }

  List<Element> getElementByStepSplitRule(
      String rule, String split, Element parent) {
    //flutter的html库无法解析有过多元素的css，比如 ul.list li
    //所以将rule分割开来，分步骤获取元素
    List<String> multiElementRule = rule.split(split);
    if (multiElementRule.length < 2) {
      return [];
    }

    List<Element> elements = [parent];
    for (var i = 0; i < multiElementRule.length; i++) {
      if (elements.isEmpty) {
        break;
      }
      var temp = List<Element>();
      for (var element in elements) {
        temp.addAll(element.querySelectorAll(multiElementRule[i]));
      }
      elements = temp;
    }
  }

  @override
  List<String> getStrings(String rule) {
    var temp = List<String>();
    var elementList = getElements(rule, true);
    for (var e in elementList) {
      temp.add(e.text);
    }
    return temp;
  }

  @override
  String formatRule(String rule) {
    return rule.replaceFirst(RegExp(RegexpRule.PARSER_TYPE_CSS), "");
  }
}
