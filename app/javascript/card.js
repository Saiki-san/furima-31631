const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  // Payjp.setPublicKeyというオブジェクトとメソッドは、先ほど導入したpayjp.jsの中で定義されているもの
  // Payjp.setPublicKey("pk_test_************************"); // PAY.JPテスト公開鍵
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    // フォームに入力されたカードの情報を、JavaScriptで取得してトークン化する
    // "charge-form"というidでフォームの情報を取得、それをFormDataオブジェクトとして生成
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    // 生成したFormDataオブジェクトから、クレジットカードに関する情報を取得し、変数cardに代入するオブジェクトとして定義
    // ★"order[number]"などは、以下のように各フォームのname属性の値のこと
    const card = {
      number: formData.get("token_address_order[number]"), // name属性
      cvc: formData.get("token_address_order[cvc]"),
      exp_month: formData.get("token_address_order[exp_month]"),
      exp_year: `20${formData.get("token_address_order[exp_year]")}`,
    };

    // Payjp.createToken(card, callback)メソッド
    // 第一引数のcardは、PAY.JP側に送るカードの情報。直前のステップで定義したカード情報のオブジェクトが入ります。
    // 第二引数のcallback(↓の場合だと、(status, response))には、PAY.JP側からトークンが送付された後に実行する処理を、アロー関数を用いた即時関数として記述
    // 即時関数 = 読み込まれると(この場合ではPAY.JPからのレスポンスがあると)即時に実行される関数
    // statusはトークンの作成がうまくなされたかどうかを確認できる、HTTPステータスコードが入ります。
    // responseはそのレスポンスの内容が含まれ、response.idとすることでトークンの値を取得することができます。
    // HTTPステータスコード(status)が200のとき、すなわちうまく処理が完了したときだけ、トークンの値(response.id)を取得するように実装していきます。
    Payjp.createToken(card, (status, response) => {
      // console.log(response)
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form"); // "charge-form"というidでフォームの情報を取得
        const tokenObj = `<input value=${token} name='token' type="hidden"> `; // HTMLのinput要素にトークンの値を埋め込み、フォームに追加、type="hidden"でtoken情報を非表示に
        renderDom.insertAdjacentHTML("beforeend", tokenObj); // フォームの中に作成したinput要素を追加
        // debugger;
      }
      // トークンを取得したので、クレジットカードの情報を削除(不要)。残ったまま次のサーバーサイドへの送信処理を行ってしまうと、クレジットカードの情報がサーバーサイドに送付されてしまい、今回トークンを生成した意味がなくなってしまいます。
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      // サーバーサイドへフォームの情報を送信
      // e.preventDefault();で通常のRuby on Railsにおけるフォーム送信処理はキャンセルされています。(7行目)
      // したがって、上記のようにJavaScript側からフォームの送信処理を行う必要がある
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);

// FormData
// FormDataとは、フォームに入力された値を取得できるオブジェクトのことです。
// new FormData(フォームの要素);のように、オブジェクトを生成し、引数にフォームの要素を渡すことで、そのフォームに入力された値を取得できます。