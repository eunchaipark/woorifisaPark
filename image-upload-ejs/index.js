// npm init -y: 기본값으로 설정된 package.json 파일을 자동으로 생성하며, 사용자 입력 없이 빠르게 package.json 파일을 설정합니다.

const express = require('express');   //express모듈을 불러와서 express변수에 할당
const multer = require('multer');   //즉 설계도 불러옴
const path = require('path');     //경로관련 유틸리티 제공하는 node.js 기본 모듈 
const fs = require('fs');   //파일시스템 관련작업하는 nodejs기본 모듈

const app = express();   //express인스턴스 생성 즉 설계도를 바탕으로 실제로 작동하는 웹서버 만듬
const PORT = 3000;

// EJS 설정
app.set('view engine', 'ejs');   // ejs를 템플릿 엔진으로 못 박음
app.set('views', path.join(__dirname, 'views'));  // 내 템플릿 파일들은 views에 있기에 거기로 디렉토리 설정

// 파일 저장을 위한 설정
const storage = multer.diskStorage({  
  destination: function (req, file, cb) {   // 경로지정
    const uploadDir = './uploads/';      // 현재 디렉토리에 uploads 폴더 파일들이 저장될거임
    if (!fs.existsSync(uploadDir)) {     //없으면 디렉토리 생성함
      fs.mkdirSync(uploadDir);
    }
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    cb(null, `${Date.now()}-${file.originalname}`);   //null 이상없으면 현재 시간과 원래 파일 이름을 결합해 고유한 파일 이름을 생성 
  }
});

// 업로드 설정
const upload = multer({ storage: storage });

// 정적 파일 제공 (업로드된 파일 조회를 위해)
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// 업로드 페이지 라우트
app.get('/', (req, res) => {
  res.render('index');
});

// 이미지 업로드 엔드포인트
app.post('/upload', upload.single('image'), (req, res) => {
  if (!req.file) {
    return res.status(400).send('No file uploaded.');
  }
  res.render('success', {
    fileName: req.file.filename,
    filePath: `/uploads/${req.file.filename}`
  });
});

// 서버 시작
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
