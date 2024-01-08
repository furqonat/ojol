package services

import (
	"apps/gate/db"
	"context"
)

type UpdateBanner struct {
	db.BannerModel
}

type Images struct {
	Link string `json:"link"`
}

func (u LugoService) CreateSetting(model *db.SettingsModel) (*string, error) {
	var s *string
	sk, ok := model.Sk()
	if ok {
		s = &sk
	}
	set, err := u.db.Settings.CreateOne(
		db.Settings.Phone.Set(model.Phone),
		db.Settings.Email.Set(model.Email),
		db.Settings.Slug.Set(model.Slug),
		db.Settings.SkFor.Set(model.SkFor),
		db.Settings.Sk.SetIfPresent(s),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return &set.ID, nil
}

func (u LugoService) UpdateSetting(id string, model *db.SettingsModel) (*string, error) {
	setting, err := u.db.Settings.FindUnique(
		db.Settings.ID.Equals(id),
	).Update(
		db.Settings.Phone.Set(model.Phone),
		db.Settings.Email.Set(model.Email),
		db.Settings.Sk.SetIfPresent(u.assignPtrStringIfTrue(model.Sk())),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return &setting.ID, nil
}

func (u LugoService) GetSetting(id string) (*db.SettingsModel, error) {
	setting, err := u.db.Settings.FindUnique(
		db.Settings.ID.Equals(id),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return setting, err
}

func (u LugoService) GetSettings(take, skip int) ([]db.SettingsModel, error) {
	settings, err := u.db.Settings.FindMany().Take(take).Skip(skip).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return settings, nil
}

func (u LugoService) CreateBanner(model *db.BannerModel) (*string, error) {
	banner, errBanner := u.db.Banner.CreateOne(
		db.Banner.Position.Set(model.Position),
	).Exec(context.Background())
	if errBanner != nil {
		return nil, errBanner
	}
	return &banner.ID, nil
}

func (u LugoService) UpdateBanner(id string, model *UpdateBanner) (*string, error) {

	description := u.assignPtrStringIfTrue(model.Description())
	url := u.assignPtrStringIfTrue(model.URL())

	banner, errUpdate := u.db.Banner.FindUnique(
		db.Banner.ID.Equals(id),
	).Update(
		db.Banner.Status.SetIfPresent(&model.Status),
		db.Banner.Description.SetIfPresent(description),
		db.Banner.URL.SetIfPresent(url),
	).Exec(context.Background())

	if errUpdate != nil {
		return nil, errUpdate
	}
	return &banner.ID, nil
}

func (u LugoService) CreateImage(bannerId string, model *db.BannerImagesModel) (*db.BannerImagesModel, error) {
	img, err := u.db.BannerImages.CreateOne(
		db.BannerImages.Link.Set(model.Link),
		db.BannerImages.Banner.Link(db.Banner.ID.Equals(bannerId)),
		db.BannerImages.URL.SetIfPresent(u.assignPtrStringIfTrue(model.URL())),
		db.BannerImages.Description.SetIfPresent(u.assignPtrStringIfTrue(model.Description())),
	).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return img, nil
}

func (u LugoService) DeleteImage(imgId string) error {
	_, err := u.db.BannerImages.FindUnique(
		db.BannerImages.ID.Equals(imgId),
	).Delete().Exec(context.Background())

	if err != nil {
		return err
	}
	return nil
}

func (u LugoService) UpdateImage(imgId string, model *db.BannerImagesModel) error {
	_, err := u.db.BannerImages.FindUnique(
		db.BannerImages.ID.Equals(imgId),
	).Update(
		db.BannerImages.URL.SetIfPresent(u.assignPtrStringIfTrue(model.URL())),
		db.BannerImages.Description.SetIfPresent(u.assignPtrStringIfTrue(model.Description())),
	).Exec(context.Background())

	if err != nil {
		return err
	}
	return nil
}

func (u LugoService) GetBanner(id string) (*db.BannerModel, error) {
	banner, err := u.db.Banner.FindUnique(
		db.Banner.ID.Equals(id),
	).With(
		db.Banner.Images.Fetch(),
	).Exec(context.Background())

	if err != nil {
		return nil, err
	}
	return banner, nil
}

func (u LugoService) GetBanners(take, skip int) ([]db.BannerModel, error) {
	banners, err := u.db.Banner.FindMany().With(db.Banner.Images.Fetch()).Take(take).Skip(skip).Exec(context.Background())
	if err != nil {
		return nil, err
	}
	return banners, nil
}

func (u LugoService) assignPtrStringIfTrue(value string, condition bool) *string {
	if condition {
		return &value
	}
	return nil
}
