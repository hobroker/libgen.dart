import 'package:libgen/src/models/book.dart';

class _BookMock {
  final Book object;
  final Map json;

  const _BookMock({this.object, this.json});
}

final singleJsonList = [darkMatterBook.json];

const darkMatterBook = _BookMock(
  object: Book(
    id: '1591104',
    md5: '7eabed69e5f2762211ec97ef972e8761',
    title: 'Dark Matter',
    author: 'Blake Crouch',
    year: '2016',
    edition: '',
    publisher: 'Crown',
    description: 'A mindbending, relentlessly surprising thriller',
    identifier: '9781101904237',
    ext: 'epub',
  ),
  json: {
    'id': '1591104',
    'title': 'Dark Matter',
    'volumeinfo': '',
    'series': '',
    'periodical': '',
    'author': 'Blake Crouch',
    'year': '2016',
    'edition': '',
    'publisher': 'Crown',
    'city': '',
    'pages': '0',
    'language': 'English',
    'topic': '',
    'library': '',
    'issue': '0',
    'identifier': '9781101904237',
    'issn': '',
    'asin': '',
    'udc': '',
    'lbc': '',
    'ddc': '',
    'lcc': '',
    'doi': '',
    'googlebookid': '',
    'openlibraryid': '',
    'commentary': '',
    'dpi': '0',
    'color': '',
    'cleaned': '',
    'orientation': '',
    'paginated': '',
    'scanned': '',
    'bookmarked': '',
    'searchable': '',
    'filesize': '478322',
    'extension': 'epub',
    'md5': '7eabed69e5f2762211ec97ef972e8761',
    'generic': '',
    'visible': '',
    'locator': 'Dark Matter - Blake Crouch.epub',
    'local': '0',
    'timeadded': '2016-12-01 10:32:36',
    'timelastmodified': '2019-12-21 21:23:21',
    'coverurl': '1591000/7eabed69e5f2762211ec97ef972e8761-g.jpg',
    'identifierwodash': '9781101904237',
    'tags': '',
    'pagesinfile': '0',
    'descr': 'A mindbending, relentlessly surprising thriller',
    'toc': '',
    'sha1': 'B7PNQU2M2NAGWPU6RWZET4AHWOTJVFFO',
    'sha256':
    'AEF0BDEFF001AE1937D542D987A5B50F1E188B8094DF777ED4377FB169E8A295',
    'crc32': '92BCB4FA',
    'edonkey': 'A3F48BCE8C942CAB907C43CEA7DE6F4E',
    'aich': 'YGQSMSV2SDEYWM6FRTLJQWXTZ4GJCE5T',
    'tth': 'GQ76I532APZPPJBIB75OYE75GYXTHWBFWS7U64I',
    'btih': '59933e2db4a2f6efbfbcde699d7eb3a33d04f116',
    'torrent': ''
  },
);