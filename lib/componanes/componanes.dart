import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:udemy/moduols/webViewscreen.dart';

Widget defaultTextField({
  required TextEditingController? controller,
  TextInputType? type,
  Function()? onTap,
  Function(String)? onChange,
  required String? Function(String?)? onValidate,
  String Function(String?)? onSubmit,
  bool isPassword = false,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  Function()? suffixPress,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onChanged: onChange,
    onTap: onTap,
    onFieldSubmitted: onSubmit,
    validator: onValidate,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(prefix),
      suffixIcon: suffix != null
          ? IconButton(onPressed: suffixPress, icon: Icon(suffix))
          : null,
      border: OutlineInputBorder(),
    ),
  );
}

Widget buildArticleItem(article, context) => InkWell(
  onTap: (){
  navigateTo(context, WebViewScreen(article['url']),);
  },
  child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  onError: (exception, stackTrace) => print('error'),
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    '${article['urlToImage']}',
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget DividerShow() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

Widget articaleBuilder(news, context) => Conditional.single(
      fallbackBuilder: (context) => Center(child: CircularProgressIndicator()),
      conditionBuilder: (context) => news.length > 0,
      context: context,
      widgetBuilder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(news[index], context),
          separatorBuilder: (context, index) => DividerShow(),
          itemCount: news.length),

      // fallback:
    );
