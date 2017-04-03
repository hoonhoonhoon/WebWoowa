# WebWow
웹테스트용

##Android

위치 : rollmind.com.webwoowa.**FullScreenActivity.java**

```swift
public class FullscreenActivity extends AppCompatActivity {

    private String urlString = "https://google.com";

    @BindView(R.id.webView)
    WebView mWebView;
```
> private String urlString = __"https://google.com";__ 의 값을 수정

##iOS

위치 : ViewController.swift

```swift
class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    let webURLString: String = "https://realm.io"

    var backgroundLabel: UILabel!
    var webView: WKWebView!
```
> let webURLString: String = __"https://realm.io"__ 의 값을 수정