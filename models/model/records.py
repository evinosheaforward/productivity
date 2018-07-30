import sqlalchemy


class Accomplishments(object):

    def __init__(self, user_info):
        #pull in the most recent data
        self.user_info = user_info
        self.get_data()

    def get_data(self):
        #Make connection to DB

        #Query for all relevent records (maybe by user basis)
        #self.data = returned_data
    def make_plots(self):
        #do plotting stuff
        pass

    def save_plots(self):
        #insert images to db
        pass
