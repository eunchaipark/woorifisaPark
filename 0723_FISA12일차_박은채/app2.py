import streamlit as st
url = 'https://docs.streamlit.io/develop/api-reference'




ani_list = ['짱구는못말려', '몬스터','릭앤모티']
img_list = ['https://i.imgur.com/t2ewhfH.png', 
             'https://i.imgur.com/MDKQoDc.jpg']
# if st.selectbox("Pick one", ["짱구", "몬스터","릭앤모티"])=='짱구':
#     st.image(img_list[0])
# elif st.selectbox("Pick one", ["짱구", "몬스터","릭앤모티"])=='몬스터':
#     st.image(img_list[1])
# else:
#     st.image('https://i.imgur.com/MDKQoDc.jpg')

# title = st.text_input('ani_name','')
# if title == '짱구':
#     st.image(img_list[0])
# elif title =='몬스터':
#     st.image(img_list[1])
# else :
#     st.image(img_list[2])

title = st.text_input("검색하실 애니메이션을 입력하세요", "")

for ani_ in ani_list:
    if title in ani_:
        # ani_list에서 특정 문자열을 포함한 인덱스를 찾아서
        img_idx = ani_list.index(ani_)

if title != '':
    st.image(img_list[img_idx])

ms = st.selectbox("검색", ["짱구", "몬스터", "릭앤모티"])
if ms == '짱구':
    st.image(img_list[0])
elif ms =='몬스터':
    st.image(img_list[1])
else :
    st.image(img_list[2])


data = 'https://i.imgur.com/ECROFMC.png'
# 검색창 
st.button("Click me")
st.download_button("Download file", data)
st.link_button("Go to gallery", url)
st.page_link("app2.py", label="Home")
#st.data_editor("Edit data", data)
st.checkbox("I agree")
st.toggle("Enable")
st.radio("Pick one", ["cats", "dogs"])
st.selectbox("Pick one", ["cats", "dogs"])
st.multiselect("Buy", ["milk", "apples", "potatoes"])
st.slider("Pick a number", 0, 100)
# st.select_slider("Pick a size", ["S", "M", "L"])
# st.text_input("First name")
# st.number_input("Pick a number", 0, 10)
# st.text_area("Text to translate")
# st.date_input("Your birthday")
# st.time_input("Meeting time")
# st.file_uploader("Upload a CSV")
# st.camera_input("Take a picture")
# st.color_picker("Pick a color")

# # Use widgets' returned values in variables:
# for i in range(int(st.number_input("Num:"))):
#     foo()
# if st.sidebar.selectbox("I:",["f"]) == "f":
#     b()
# my_slider_val = st.slider("Quinn Mallory", 1, 88)
# st.write(slider_val)

# # Disable widgets to remove interactivity:
# st.slider("Pick a number", 0, 100, disabled=True)
# # 입력창에서 데이터를 받아서 

st.image(img_list[1])
# 해당 문자열이 일치하는 이미지를 화면에 출력해 보세요.

