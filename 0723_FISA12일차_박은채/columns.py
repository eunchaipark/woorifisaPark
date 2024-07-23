import streamlit as st

# Using object notation
add_selectbox = st.sidebar.selectbox(
    "How would you like to be contacted?",
    ("Email", "Home phone", "Mobile phone")
)

# Using "with" notation  with문안에 있기에 사이브바에 나타난다.
with st.sidebar:
    add_radio = st.radio(
        "Choose a shipping method",
        ("Standard (5-15 days)", "Express (2-5 days)")
    )

    st.write(add_selectbox)
    st.write(add_radio)
    
col1, col2 = st.columns(2)  #컬럼은 2개인데 첫번째는 col1 두번쨰는 col2
col1.write('Column 1')
col1.header('HEADER')
col2.write('Column 2')
col2.header('header2')
# Three columns with different widths
col1, col2, col3 = st.columns([3,1,1])  #5등분해서 3:1:1로 비율을 차지
# col1 is wider

# Using 'with' notation:
with col1:
    st.image('https://i.imgur.com/MDKQoDc.jpg')
with col2:
    st.image('https://i.imgur.com/t2ewhfH.png')
with col3:
    st.image('https://i.imgur.com/ECROFMC.png')