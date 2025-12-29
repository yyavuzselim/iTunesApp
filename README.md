iTunes Search App
Bu proje, iTunes Search API kullanarak film, müzik, ebook ve podcast araması
yapabilen basit bir iOS uygulamasıdır.

Projeyi yaparken amacım:
- UIKit pratiği yapmak
- API ile veri çekme sürecini öğrenmek
- Temiz ve anlaşılır bir yapı kurmaktı

Uygulamada Neler Var?

- Arama çubuğu ile iTunes üzerinden arama
- Segment kontrol ile medya türü seçme
  - Movie
  - Music
  - Ebook
  - Podcast
- Sonuçları CollectionView içinde listeleme
- Bir elemana tıklayınca detay ekranına gitme
- Resimleri internetten çekme
- 
Proje Yapısı

Projeyi MVC (Model – View – Controller)** yapısına uygun olacak şekilde
oldukça basit tuttum.

Modeller

SearchResponse & SearchResult
Bunlar API’den gelen JSON yapısını temsil ediyor.


SearchItem
Bu model ise UI’da kullanılan model.

Neden ayrı bir model kullandım?
- ViewController içinde karmaşık if let yapıları olmasın diye
- Fiyat ve tarih gibi bilgileri önceden formatlamak için
- UI tarafını API detaylarından ayırmak için

API Servisi

Tüm network işlemlerini ApiService içinde topladım.

- Alamofire kullandım
- ViewController içinde direkt network kodu yazmamak için
- Tek bir yerden yönetmek daha temiz olduğu için

API’den gelen veriler önce decode ediliyor,
sonra SearchItem listesine dönüştürülüp ekrana gönderiliyor.

 Resim Yükleme

Resimleri göstermek için Kingfisher kullandım. Kullanmayıda bu projede öğrendim.

Sebebi:
- Asenkron çalışıyor
- Cache desteği var
- Kullanımı kolay
- Placeholder gösterebiliyor

Arama Süreci Nasıl Çalışıyor?

1. Kullanıcı search bar’a yazı yazıyor
2. En az 3 karakter girilince API çağrısı yapılıyor
3. Seçili segment’e göre medya türü belirleniyor
4. API’den gelen sonuçlar decode ediliyor
5. UI için uygun hale getiriliyor
6. CollectionView yenileniyor

 Kullanılan Teknolojiler

- Swift
- UIKit
- Alamofire
- Kingfisher
